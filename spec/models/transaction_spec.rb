require 'rails_helper'

RSpec.describe Transaction do
  describe 'Validation definitions' do
    subject(:transaction) { build(:transaction) }

    it { is_expected.to validate_presence_of(:token) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:amount) }

    it {
      expect(transaction).to define_enum_for(:status)
        .with_values(
          started: 1, authenticated: 5, pending: 10, completed: 15,
          canceled: 20
        )
    }

    it {
      expect(transaction).to validate_numericality_of(:amount)
        .is_greater_than(0)
    }

    it { 
      is_expected.to validate_uniqueness_of(:token)
    }
  end

end
