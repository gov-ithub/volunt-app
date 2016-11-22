require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

#RSpec.describe MeetingsController, type: :controller do
#
#  # This should return the minimal set of attributes required to create a valid
#  # Meeting. As you add validations to Meeting, be sure to
#  # adjust the attributes here as well.
#  let(:valid_attributes) {
#    skip("Add a hash of attributes valid for your model")
#  }
#
#  let(:invalid_attributes) {
#    skip("Add a hash of attributes invalid for your model")
#  }
#
#  # This should return the minimal set of values that should be in the session
#  # in order to pass any filters (e.g. authentication) defined in
#  # MeetingsController. Be sure to keep this updated too.
#  let(:valid_session) { {} }
#
#  describe "GET #index" do
#    it "assigns all meetings as @meetings" do
#      meeting = FactoryGirl.create(:meeting)
#      get :index, params: {}, session: valid_session
#      expect(assigns(:meetings)).to eq([meeting])
#    end
#  end
#
#  describe "GET #show" do
#    it "assigns the requested meeting as @meeting" do
#      meeting = FactoryGirl.create(:meeting)
#      get :show, params: {id: meeting.to_param}, session: valid_session
#      expect(assigns(:meeting)).to eq(meeting)
#    end
#  end
#
#  describe "GET #new" do
#    it "assigns a new meeting as @meeting" do
#      get :new, params: {}, session: valid_session
#      expect(assigns(:meeting)).to be_a_new(Meeting)
#    end
#  end
#
#  describe "GET #edit" do
#    it "assigns the requested meeting as @meeting" do
#      meeting = FactoryGirl.create(:meeting)
#      get :edit, params: {id: meeting.to_param}, session: valid_session
#      expect(assigns(:meeting)).to eq(meeting)
#    end
#  end
#
#  describe "POST #create" do
#    context "with valid params" do
#      it "creates a new Meeting" do
#        expect {
#          post :create, params: {meeting: valid_attributes}, session: valid_session
#        }.to change(Meeting, :count).by(1)
#      end
#
#      it "assigns a newly created meeting as @meeting" do
#        post :create, params: {meeting: valid_attributes}, session: valid_session
#        expect(assigns(:meeting)).to be_a(Meeting)
#        expect(assigns(:meeting)).to be_persisted
#      end
#
#      it "redirects to the created meeting" do
#        post :create, params: {meeting: valid_attributes}, session: valid_session
#        expect(response).to redirect_to(Meeting.last)
#      end
#    end
#
#    context "with invalid params" do
#      it "assigns a newly created but unsaved meeting as @meeting" do
#        post :create, params: {meeting: invalid_attributes}, session: valid_session
#        expect(assigns(:meeting)).to be_a_new(Meeting)
#      end
#
#      it "re-renders the 'new' template" do
#        post :create, params: {meeting: invalid_attributes}, session: valid_session
#        expect(response).to render_template("new")
#      end
#    end
#  end
#
#  describe "PUT #update" do
#    context "with valid params" do
#      let(:new_attributes) {
#        skip("Add a hash of attributes valid for your model")
#      }
#
#      it "updates the requested meeting" do
#        meeting = FactoryGirl.create(:meeting)
#        put :update, params: {id: meeting.to_param, meeting: new_attributes}, session: valid_session
#        meeting.reload
#        skip("Add assertions for updated state")
#      end
#
#      it "assigns the requested meeting as @meeting" do
#        meeting = FactoryGirl.create(:meeting)
#        put :update, params: {id: meeting.to_param, meeting: valid_attributes}, session: valid_session
#        expect(assigns(:meeting)).to eq(meeting)
#      end
#
#      it "redirects to the meeting" do
#        meeting = FactoryGirl.create(:meeting)
#        put :update, params: {id: meeting.to_param, meeting: valid_attributes}, session: valid_session
#        expect(response).to redirect_to(meeting)
#      end
#    end
#
#    context "with invalid params" do
#      it "assigns the meeting as @meeting" do
#        meeting = FactoryGirl.create(:meeting)
#        put :update, params: {id: meeting.to_param, meeting: invalid_attributes}, session: valid_session
#        expect(assigns(:meeting)).to eq(meeting)
#      end
#
#      it "re-renders the 'edit' template" do
#        meeting = FactoryGirl.create(:meeting)
#        put :update, params: {id: meeting.to_param, meeting: invalid_attributes}, session: valid_session
#        expect(response).to render_template("edit")
#      end
#    end
#  end
#
#  describe "DELETE #destroy" do
#    it "destroys the requested meeting" do
#      meeting = FactoryGirl.create(:meeting)
#      expect {
#        delete :destroy, params: {id: meeting.to_param}, session: valid_session
#      }.to change(Meeting, :count).by(-1)
#    end
#
#    it "redirects to the meetings list" do
#      meeting = FactoryGirl.create(:meeting)
#      delete :destroy, params: {id: meeting.to_param}, session: valid_session
#      expect(response).to redirect_to(meetings_url)
#    end
#  end
#
#end