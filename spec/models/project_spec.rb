require 'rails_helper'

describe Project, type: :model do
  let(:project) { create :project }

  it { is_expected.to have_many :members }
  it { is_expected.to have_many :profiles }
  it { is_expected.to have_many :status_reports }
  it { is_expected.to have_many :openings }

  it { is_expected.to belong_to :owner }

  it 'is valid with valid attributes' do
    expect(project).to be_valid
  end
end