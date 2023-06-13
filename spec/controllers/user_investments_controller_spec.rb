RSpec.describe UserInvestmentsController, type: :controller do
  describe 'index action' do
    let(:user) { create(:user, role: :premium) }
    let!(:account) { create(:account, user: user, balance: 1000) }
    let!(:user_investments) { create_list(:user_investment, 3, user: user, initial_amount: 200) }


    before { sign_in(user) }

    it 'assigns user_investments' do
      get :index
      expect(assigns(:user_investments)).to match_array(user_investments)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'catalogs action' do
    let(:user) { create(:user) }
    let!(:investments) { create_list(:investment, 3) }

    before { sign_in(user) }

    it 'assigns investments' do
      get :catalogs
      expect(assigns(:investments)).to match_array(investments)
    end

    it 'renders the catalogs template' do
      get :catalogs
      expect(response).to render_template(:catalogs)
    end
  end

  describe 'destroy action' do
    let(:user) { create(:user) }
    let!(:account) { create(:account, user: user, balance: 200) }
    let(:user_investment) { create(:user_investment, user: user, investment: create(:investment, minimum_amount: 50), initial_amount: 100) }
    before { sign_in(user) }

    it 'updates the account balance after rescue' do
      expect(user_investment).to receive(:update_account_balance_after_rescue)
      user_investment.update_account_balance_after_rescue
      delete :destroy, params: { id: user_investment.id }
    end

    it 'redirects to user_investments_path' do
      delete :destroy, params: { id: user_investment.id }
      expect(response).to redirect_to(user_investments_path)
    end

    it 'flash success message' do
      delete :destroy, params: { id: user_investment.id }
      expect(flash[:notice]).to eq('Investimento apagado com sucesso')
    end
  end
end

