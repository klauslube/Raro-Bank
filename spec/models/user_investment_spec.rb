require 'rails_helper'

RSpec.describe UserInvestment do
  describe 'Validation definitions' do
    subject(:user_investment) { build(:user_investment) }

    it { is_expected.to validate_presence_of(:initial_amount) }

    it {
      expect(user_investment).to validate_numericality_of(:initial_amount)
        .is_greater_than(0)
    }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:investment) }
  end

end
