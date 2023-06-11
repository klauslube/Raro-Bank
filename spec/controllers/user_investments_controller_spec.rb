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
end
