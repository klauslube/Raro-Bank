require 'rails_helper'

RSpec.describe Investment do
  describe 'Validation definitions' do
    subject(:investment) { build(:investment) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:minimum_amount) }
    it { is_expected.to validate_presence_of(:expiration_date) }
    it { is_expected.to validate_presence_of(:start_date) }

    it {
      expect(investment).to allow_value(%w[true false]).for(:premium)
    }

    it {
      expect(investment).to validate_numericality_of(:minimum_amount)
        .is_greater_than(0)
    }

    it {
      expect(investment).to validate_length_of(:name)
        .is_at_least(1).is_at_most(15)
    }

    xit 'should be invalid when expiration_date is before start_date' do
      investment.start_date = Date.today
      investment.expiration_date = Date.today - 1
      investment.save
      expect(investment).to be_invalid
      expect(investment.errors).to include(:expiration_date)
      expect(investment.errors[:expiration_date]).to include('must be after start date')
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:approver).class_name('User') }
    it { is_expected.to have_many(:user_investments).class_name('UserInvestment').dependent(:destroy) }
    it { is_expected.to have_many(:users).through(:user_investments) }
    it { is_expected.to belong_to(:indicator) }
  end

end
