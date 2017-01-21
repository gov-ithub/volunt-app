require 'rails_helper'

describe ProjectMember, type: :model do
  let(:project_member) { create :project_member }

  it { is_expected.to belong_to :project }
  it { is_expected.to belong_to :profile }

  it { is_expected.to validate_presence_of(:role) }
  it { is_expected.to validate_presence_of(:project_id) }
  it { is_expected.to validate_presence_of(:profile_id) }

  it 'is valid with valid attributes' do
    expect(project_member).to be_valid
  end
end