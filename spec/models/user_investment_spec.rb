require 'rails_helper'

RSpec.describe UserInvestment do
  describe 'Validation definitions' do
    subject(:user_investment) { build(:user_investment) }

    it { is_expected.to validate_presence_of(:initial_amount) }

    xit { expect(user_investment).to validate_numericality_of(:initial_amount).is_greater_than(0) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:investment) }
  end

  describe 'Model Methods' do 
    describe 'set_initial_profit' do
      let(:user) { create(:user) }
      let(:account) { create(:account, user: user, balance: 100) }
      let(:user_investment) { build(:user_investment, initial_amount: 100) }
 
      it 'sets the profit to the initial amount' do
        user_investment.send(:set_initial_profit)
        expect(user_investment.profit).to eq(100)
      end
    end

    describe 'balance_account_enough?' do
      let(:user) { create(:user) }
      let(:account) { create(:account, user: user, balance: 100) }
      let(:user_investment) { build(:user_investment, user: user, investment: create(:investment), initial_amount: 150) }
  
      it 'adds an error if the account balance is less than the initial amount' do
        user_investment.send(:balance_account_enough?)
        expect(user_investment.errors[:base]).to include('Balance is not enough')
      end
    end

    describe 'premium_investment_available?' do
      let(:user) { create(:user) }
      let(:premium_investment) { create(:investment, premium: true) }
      let(:user_investment) { build(:user_investment, user: user, investment: premium_investment) }
  
      context 'when the user is a free user' do
        before { user.role = 'free' }
  
        it 'adds an error if the investment is premium' do
          user_investment.send(:premium_investment_available?)
          expect(user_investment.errors[:base]).to include('Premium investments are not available for free users')
        end
      end
  
      context 'when the user is not a free user' do
        before { user.role = 'premium' }
  
        it 'does not add an error if the investment is premium' do
          user_investment.send(:premium_investment_available?)
          expect(user_investment.errors[:base]).to be_empty
        end
      end
    end
  
    describe 'update_account_balance' do
      let(:user) { create(:user) }
      let!(:account) { create(:account, user: user, balance: 100) }
      let(:user_investment) { create(:user_investment, user: user, investment: create(:investment, minimum_amount: 50), initial_amount: 100) }
  
      it 'updates the account balance by subtracting the initial amount' do
        user_investment.update_account_balance
        account.reload
        expect(account.balance).to eq(0)
      end
    end
  
    describe 'update_account_balance_after_rescue' do
      let(:user) { create(:user) }
      let!(:account) { create(:account, user: user, balance: 100) }
      let(:user_investment) { create(:user_investment, user: user, investment: create(:investment, minimum_amount: 50 ), initial_amount: 100, profit: 100) }
  
      it 'updates the account balance by adding the profit amount' do
        user_investment.update_account_balance_after_rescue
        account.reload
        expect(account.balance).to eq(200)
      end
    end
  

  
    describe 'initial_amount_enough?' do
      let(:user) { create(:user) }
      let!(:account) { create(:account, user: user, balance: 100) }
      # let!(:investment) { create(:investment, minimum_amount: 100) }
      let(:user_investment) { create(:user_investment, user: user, investment: create(:investment, minimum_amount: 500), initial_amount: 100) }
  
      xit 'adds an error if the initial amount is less than the minimum amount' do
        user_investment.send(:initial_amount_enough?)
        expect(user_investment.errors[:initial_amount]).to include('needs to be more than the minimum amount')
      end
    end

  end
end
