require 'rails_helper'

RSpec.describe Transaction do 
  describe 'Validation definitions' do
    let(:transaction) { create(:transaction) }
    let(:transaction2) { create(:transaction) }
    let(:valid_attributes) { create(:transaction).as_json.tap do |hash|
      hash['receiver_cpf'] = Account.find(hash['receiver_id']).user.cpf
      hash.delete('receiver_id')
    end
    }
    let(:invalid_attributes) { attributes_for(:transaction, sender_id: nil) }

    subject(:transaction) { build(:transaction) }

    xit { should validate_presence_of :token }
    xit { should validate_presence_of :amount }
    xit { should validate_presence_of :status }
    xit { expect(transaction).to define_enum_for(:status).with_values(
      started: 1, authenticated: 5, pending: 10, completed: 15, canceled: 20
      )}
    xit { expect(transaction).to validate_numericality_of(:amount).is_greater_than(0)}
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
