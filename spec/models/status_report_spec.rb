require 'rails_helper'

describe StatusReport, type: :model do
  let(:status_report) { create :status_report }

  it { is_expected.to belong_to :project }
  it { is_expected.to belong_to :profile }
  it { is_expected.to belong_to :author }

  it { is_expected.to validate_presence_of(:summary) }

  it 'is valid with valid attributes' do
    expect(status_report).to be_valid
  end
end