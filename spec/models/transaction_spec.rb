require 'rails_helper'

RSpec.describe Transaction do
  describe 'Validation definitions' do
    subject(:transaction) { build(:transaction) }

    it { should validate_presence_of :token }
    it { should validate_presence_of :amount }
    it { should validate_presence_of :status }
    it { expect(transaction).to define_enum_for(:status).with_values(
      started: 1, authenticated: 5, pending: 10, completed: 15, canceled: 20
      )}
    it { expect(transaction).to validate_numericality_of(:amount).is_greater_than(0)}
    it {
      transaction1 = create(:transaction)
      transaction2 = build(:transaction, token: transaction1.token)
      expect(transaction2).not_to be_valid
      expect(transaction2.errors[:token]).to include('has already been taken')
    }
  end

  describe 'Associations' do
    it { 
      is_expected.to belong_to(:sender).class_name('Account')
    }
    it { 
      is_expected.to belong_to(:receiver).class_name('Account')
    }
  end
end
