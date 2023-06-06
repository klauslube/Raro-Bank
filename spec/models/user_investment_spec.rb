# require 'rails_helper'

# RSpec.describe UserInvestment do
#   describe 'Validation definitions' do
#     subject(:user_investment) { build(:user_investment) }

#     it { is_expected.to validate_presence_of(:initial_amount) }

#     it {
#       expect(user_investment).to validate_numericality_of(:initial_amount)
#         .is_greater_than(0)
#     }
#   end

#   describe 'Associations' do
#     it { is_expected.to belong_to(:user) }
#     it { is_expected.to belong_to(:investment) }
#   end

#   describe 'Scopes' do
#     subject(:user) { create(:user) }
#     subject(:user2) { create(:user) }

#     subject(:investment) { create(:investment) }
    
#     subject(:user_investment) { create(:user_investment, user: user, investment: investment) }
#     subject(:user_investment2) { create(:user_investment, user: user2, investment: investment) }
    
#     it 'returns all investments of the chosen user' do
#       expect(UserInvestment.by_user(user)).to contain_exactly(user_investment)
#     end

#     it 'does not return investments of other users' do
#       expect(UserInvestment.by_user(user)).not_to include(user_investment2)
#     end
#   end

# end
