require 'rails_helper'

describe SearchConcern do
 before do
    class FakesSearchConcern
      include SearchConcern
    end
  end
  after { Object.send :remove_const, :FakesSearchConcern }

  let(:object) { FakesSearchConcern.new }
  let(:profile) { create :profile, full_name: 'Cătălin' }
  let(:names_search_values) { %w(căt cat Căt Cat Cătălin Catalin tălin talin taLin) }

  it 'does insensitive and unaccented search' do
    names_search_values.each do |name|
      query = object.chain_where_like(Profile, :full_name, name)
      expect(query).to include profile
    end

    names_search_values.map { |e| "NOT #{e}" }.each do |name|
      query = object.chain_where_like(Profile, :full_name, name)
      expect(query).to_not include profile
    end
  end
end
