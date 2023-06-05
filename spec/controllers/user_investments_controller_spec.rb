require 'rails_helper'

RSpec.describe UserInvestmentsController, type: :controller do
  describe "Authenticated as free user" do
    let(:free) { create(:user_confirmed, role: :free) }
    let(:premium) { create(:user_confirmed, role: :premium) }
    let(:investment) { create(:investment)}
    let(:free_investment) { create(:investment, premium: false) }
    let(:premium_investment) { create(:investment, premium: true) }
    let!(:free_user_investment) { create(:user_investment, user: free, investment: free_investment) }
    let!(:premium_user_investment) { create(:user_investment, user: premium, investment: premium_investment) }

    # let(:valid_attributes) { attributes_for(:investment) }
    # let(:invalid_attributes) { attributes_for(:investment, name: nil) }
    before :each do
      sign_in free
    end

    context '#index' do
      # it "assigns only free user investments to user_investments" do
      #   expect(assigns(user_investments)).to eq([free_user_investment])
      # end

      it 'renders the index template' do
        get :index
        expect(response).to render_template(:index)
      end
    end

  end
end
