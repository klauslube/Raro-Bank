require 'rails_helper'

RSpec.describe Indicator do
  describe 'name_with_rate' do
    let(:indicator) { create(:indicator, name: 'Indicator A', rate: 1.5) }

    it 'returns the name with the rate' do
      expect(indicator.name_with_rate).to eq('Indicator A - 1.5')
    end
  end
end
