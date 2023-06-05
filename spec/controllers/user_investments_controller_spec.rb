# require 'rails_helper'

# RSpec.describe UserInvestmentsController, type: :controller do
#   let(:free) { create(:user_confirmed, role: :free) }
#   let(:premium) { create(:user_confirmed, role: :premium) }
#   let(:investment) { create(:investment)}
#   let(:free_investment) { create(:investment, premium: false) }
#   let(:premium_investment) { create(:investment, premium: true) }
#   let(:free_user_investment) { create(:user_investment, user: free, investment: free_investment) }
#   let(:premium_user_investment) { create(:user_investment, user: premium, investment: premium_investment) }

#   # let(:valid_attributes) { attributes_for(:investment) }
#   # let(:invalid_attributes) { attributes_for(:investment, name: nil) }
#   describe 'Action #index' do
   
#     context 'when user is free' do
#       before :each do
#         sign_in free
#       end

#       it "assigns only free user investments to user_investments" do
#         expect(assigns(:user_investments)).to eq([free_user_investment])
#       end
  
#       it 'renders the index template' do
#         get :index
#         expect(response).to render_template(:index)
#       end
#     end
  
#     context "when user is premium" do
#       before :each do
#         sign_in premium
#       end
  
#       # it "assigns all user investments to @user_investments" do
#       #   expect(assigns(:user_investments)).to eq([free_user_investment, premium_user_investment])
#       # end
  
#       it "renders the index template" do
#         expect(response).to render_template(:index)
#       end
#     end
#   end

#   describe 'Action #new' do
#     it "assigns a new user investment to @user_investment" do
#       expect {
#         post :create, params: { user_investment: valid_attributes }
#       }.to change(Investment, :count).by(1)
#     end
  
#     it "assigns all investments to @investments" do
#       investments = Investment.all
#       get :new
#       expect(assigns(:investments)).to eq(investments)
#     end
  
#     it "returns a success response" do
#       get :new
#       expect(response).to be_successful
#     end
  
#     it "renders the new template" do
#       get :new
#       expect(response).to render_template(:new)
#     end
#   end
# end
