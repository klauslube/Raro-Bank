require 'rails_helper'

RSpec.describe Admin::InvestmentsController, type: :controller do
  describe "Authenticated as admin user" do
    let(:admin) { create(:user_confirmed, role: :admin) }
    let(:investment) { create(:investment)}
    before :each do
      sign_in admin
    end

    context '#index' do
      it 'should respond with 200' do
        get :index
        expect(response).to have_http_status(200)
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context '#show' do
      it 'should respond with 200' do
        get :show, params: { id: investment.id }
        expect(response).to have_http_status(200)
      end

      it 'renders the show template' do
        get :show, params: { id: investment.id }
        expect(response).to render_template(:show)
      end
    end 
  end
end
