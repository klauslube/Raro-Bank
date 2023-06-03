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

    context '#new' do
      it 'should respond with 200' do
        get :new
        expect(response).to have_http_status(200)
      end

      it 'renders the new template' do
        get :new
        expect(response).to render_template(:new)
      end
    end

    context '#create' do
      let(:valid_attributes) { attributes_for(:investment) }
      let(:invalid_attributes) { attributes_for(:investment, name: nil) }

      it 'creates a new investment' do
        expect {
          post :create, params: { investment: valid_attributes }
        }.to change(Investment, :count).by(1)
      end

      it 'show success notice when investment is created' do
        post :create, params: { investment: valid_attributes }
        expect(flash[:notice]).to match(/Investment was successfully created./)
      end

      # it 'redirects to the investment when create success' do
      #   post :create, params: { investment: valid_attributes }
      #   expect(response).to redirect_to(investment)
      # end

      it 'try to create with invalid attributes' do
        expect {
          post :create, params: { investment: invalid_attributes }
        }.not_to change(Investment, :count)
      end

      it 'renders :new with status :unprocessable_entity when save fails' do
        post :create, params: { investment: invalid_attributes }
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
