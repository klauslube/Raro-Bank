require 'rails_helper'

RSpec.describe Account do
  describe 'Relations' do
    it { should belong_to(:user) }
    it { should have_many(:receiver_transactions) }
    it { should have_many(:receiver_transactions) }
  end

  describe 'Validation definitions' do
    subject(:account) { build(:account) }

    it { is_expected.to validate_presence_of(:balance) }

    it {
      expect(account).to validate_numericality_of(:balance)
        .is_greater_than_or_equal_to(0)
    }
  end

  describe 'Scopes'
    describe '#not_admin' do
    let!(:admin) { create(:user, role: :admin) }
    let!(:user) { create(:user) }

    it 'should return only accounts that are not admin' do
      expect(Account.not_admin).to eq([user.account])
    end

    it 'should not return accounts that are admin' do
      expect(Account.not_admin).not_to include(admin.account)
    end
  end
end