require 'rails_helper'

RSpec.describe Transaction do
  describe 'Validation definitions' do
    subject(:transaction) { build(:transaction) }

    xit { should validate_presence_of :token }
    xit { should validate_presence_of :amount }
    xit { should validate_presence_of :status }
    xit { expect(transaction).to define_enum_for(:status).with_values(
      started: 1, authenticated: 5, pending: 10, completed: 15, canceled: 20
      )}
    xit { expect(transaction).to validate_numericality_of(:amount).is_greater_than(0)}
    xit {
      transaction1 = create(:transaction)
      transaction2 = build(:transaction, token: transaction1.token)
      expect(transaction2).not_to be_valid
      expect(transaction2.errors[:token]).to include('has already been taken')
    }
  end

  describe 'Associations' do
    xit { 
      is_expected.to belong_to(:sender).class_name('Account')
    }
    xit { 
      is_expected.to belong_to(:receiver).class_name('Account')
    }
  end
end
