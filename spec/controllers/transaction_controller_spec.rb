require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  describe "Authenticated users" do
    let(:user) { create(:user_confirmed, role: :free) }
    let(:transaction) { create(:transaction)}
    let(:valid_attributes) { create(:transaction).as_json.tap do |hash|
      hash['receiver_cpf'] = Account.find(hash['receiver_id']).user.cpf
      hash.delete('receiver_id')
    end
    }
    let(:invalid_attributes) { attributes_for(:transaction, sender_id: nil) }
    before :each do
      sign_in user
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
        get :show, params: { id: transaction.id }
        expect(response).to have_http_status(200)
      end

      it 'renders the show template' do
        get :show, params: { id: transaction.id }
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
      before do
        @user = create(:user)
        @transaction = create(:transaction)
      end
      it 'creates a new transaction' do
        expect {
        post :create, params: { transaction: valid_attributes }
        }.to change(Transaction, :count).by(1)
      end

      it 'try to create with invalid attributes' do
        expect {
          post :create, params: { transaction: invalid_attributes }
        }.not_to change(Transaction, :count)
      end
    end
  end
end