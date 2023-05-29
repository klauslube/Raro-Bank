require 'rails_helper'

RSpec.describe Account do
  describe 'Validation definitions' do
    subject(:account) { build(:account) }

    it { is_expected.to validate_presence_of(:balance) }

    it {
      expect(account).to validate_numericality_of(:balance)
        .is_greater_than_or_equal_to(0)
    }
  end

end