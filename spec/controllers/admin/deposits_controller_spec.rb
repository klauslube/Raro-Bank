require 'rails_helper'

RSpec.describe Admin::DepositsController, type: :controller do
  describe 'GET #new' do
    it 'should assigns a new classroom to @classroom' do
      get :new

      expect(assigns(:transaction)).to be_a_new(Transaction)
    end

    it 'should renders the new deposit form template' do
      get :new

      expect(response).to render_template(:new)
    end
  end

  let(:user) { create(:user) }
  let(:classroom) { create(:classroom) }
  let(:amount) { 100 }
  let(:cpf) { '1234567890' }
  let(:token) { 'abc123' }
  let(:receivers) { create_list(:account, 3) }

  describe 'POST #create' do
    context 'with valid parameters' do
      before do
        allow(controller).to receive(:current_user).and_return(user)
        allow(subject).to receive(:fetch_receiver_by_cpf).and_return(receivers.first)
        allow(subject).to receive(:generate_token).and_return(token)
        allow_any_instance_of(Transaction).to receive(:save).and_return(true)
        post :create, params: { transaction: { classroom_id: classroom.id, amount: amount, receiver_cpf: cpf } }
      end


      it 'saves the transactions' do
        expect(response).to redirect_to(admin_root_path)
        expect(flash[:notice]).to eq(I18n.t('admin.deposits.create.success'))
      end
    end

    context 'with invalid parameters' do
      before do
        post :create, params: { transaction: { classroom_id: nil, amount: 1, receiver_cpf: nil } }
      end


      it 'redirects to admin deposits path' do
        expect(response).to redirect_to(admin_deposits_path)
      end

      it 'sets an alert flash message' do
        expect(flash[:alert]).to eq(I18n.t('admin.deposits.create.receiver_error'))
      end
    end
  end
end
