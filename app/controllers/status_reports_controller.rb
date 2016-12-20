class StatusReportsController < ApplicationController
  include LoginConcern

  authorization_required LoginConcern::USER_LEVEL_FELLOW,
    except: [:index, :show]
  authorization_required LoginConcern::USER_LEVEL_VOLUNTEER,
    only: [:index, :show]

  before_action :set_status_report, only: [:show, :edit, :update, :destroy]
  before_action :set_profile_or_project, only: [:new, :create, :index]

  # GET /status_reports/my
  def my
    @my_status_report = MyStatusReportPresenter.get_current(current_user_profile)
  end

  # GET /status_reports/my/edit
  def my_edit
    @my_status_report = MyStatusReportPresenter.get_current(current_user_profile)
  end

  def my_publish
    @my_status_report = MyStatusReportPresenter.get_current(current_user_profile)
    if @my_status_report.publish
      redirect_to my_status_reports_path, notice: 'Raportul a fost publicat. Acesta este raportul pentru perioada urmatoare.'
    else
      flash.now[:notice]='Raportul nu a putut fi publicat'
      render :my_edit
    end
  end

  # POST /status_reports/my_edit
  def my_edit_post
    if params.has_key?(:publish_report)
      self.my_publish
      return
    end
    @my_status_report = MyStatusReportPresenter.from_params(params.require(:my_status_report_presenter))
    if params.has_key?(:save) and  @my_status_report.valid? and @my_status_report.save
      redirect_to my_status_reports_path, notice: 'Status was saved'
    elsif params.has_key?(:add_project)
      @my_status_report.add_project
      project_ids = @my_status_report.project_status_reports.inject([]) do |arr, psr|
          arr << psr.project.id unless psr.project.nil?
          arr
        end
      @projects_for_select = Project.where.not(id: project_ids)
      render :my_edit
    else
      render :my_edit
    end
  end

  # GET /status_reports
  def index
    if not @project.nil?
      @status_reports = @project.status_reports
    elsif not @profile.nil?
      @status_reports = @profile.status_reports
    else
      @status_reports = StatusReport.all
    end
    @status_reports = @status_reports.paginate(page: params[:page])
  end

  # GET /status_reports/1
  def show
  end

  # GET /projects/1/status_reports/new
  # GET /fellows/1/status_reports/new
  def new
    @status_report = StatusReport.new(report_date: Date.today, author: current_user_profile)
    @status_report.profile = @profile unless @profile.nil?
    @status_report.project = @project unless @project.nil? 
  end

  # GET /status_reports/1/edit
  def edit
  end

  # POST /projects/1/status_reports
  # POST /fellows/1/status_reports
  def create
    @status_report = StatusReport.new(status_report_params)
    @status_report.author = current_user_profile
    @status_report.profile = @profile unless @profile.nil?
    @status_report.project = @project unless @project.nil? 

    if @status_report.save
      redirect_to back_path, notice: 'Status report was successfully created.'
    else
      puts @status_report.errors.inspect
      render :new
    end
  end

  # PATCH/PUT /status_reports/1
  # because of the btn group layout in show, :delete is posted as a :post with submit named 'delete_report'
  def update
    if params.has_key? 'delete_report'
      self.destroy
      return
    end

    if params.has_key? 'publish_report'
      if @status_report.publish
        redirect_to @status_report, notice: 'Raportul a fost publicat'
        return
      else
        flash.now[:notice] = 'Raportul nu a putut fi publicat'
        render :edit
        return
      end
    end
    
    if @status_report.update(status_report_params)
      redirect_to @status_report, notice: 'Status report was successfully updated.'
      return
    else
      flash.now[:notice] = 'Raportul nu a putut fi salvat'
      render :edit
    end
  end

  # DELETE /status_reports/1
  def destroy
    @status_report.destroy
    redirect_to back_path, notice: 'Status report was successfully destroyed.'
  end

  helper_method :back_path, :form_submit_path
  def back_path
    return fellow_path(@profile) unless @profile.nil?
    return project_path(@project) unless @project.nil?
    return status_reports_path
  end

  def form_submit_path
    return status_report_path(@status_report) unless @status_report.new_record?
    return fellow_status_reports_path(@profile) unless @profile.nil?
    return project_status_reports_path(@project) unless @project.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status_report
      @status_report = StatusReport.find(params[:id])
      @project = @status_report.project
      @profile = @status_report.profile
    end

    def set_profile_or_project
      @project = Project.find(params[:project_id]) if params.has_key? :project_id
      @profile = Profile.fellows.find(params[:fellow_id]) if params.has_key? :fellow_id
    end

    # Only allow a trusted parameter "white list" through.
    def status_report_params
      params.fetch(:status_report, {}).permit(
          :profile_id,
          :project_id,
          :summary,
          :details,
          :report_date,
          :tags_string,
          :status
        )
    end
end
