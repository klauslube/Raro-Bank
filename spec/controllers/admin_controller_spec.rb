require "rails_helper"

RSpec.describe AdminController, type: :controller do
  context "Unauthenticated" do
    it "should raise error: not free or premium user" do
        # Simula um usuário não autenticado
        allow(controller).to receive(:authenticate_admin!).and_raise(StandardError.new("not_an_admin"))

        # Executa a ação GET no método index
        expect { get :index }.to raise_error(StandardError, "not_an_admin")
    end

    it 'should respond with 302' do
      get :index
      expect(response).to have_http_status(302)
    end

    it 'should redirect to login' do
      get :index
      expect(response).to redirect_to('/')
    end
  end

  describe "#index" do
    context "Authenticated as admin user" do
      let(:admin) { create(:user_confirmed, role: :admin) }

      before do
        sign_in admin
      end

      it "should respond with 200" do
        get :index
        # byebug
        expect(response).to have_http_status(200)
      end

      it "should render index template" do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context "Unauthorized as free user" do
      let(:user) { create(:user) }

      before do
        sign_in user
      end

      it "should respond with 302" do
        get :index
        # byebug
        expect(response).to have_http_status(302)
      end

      it "should be redirect to login" do
        get :index
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    context "Unauthorized as premium user" do
      let(:user) { create(:user, role: :premium) }

      before do
        sign_in user
      end

      it "should respond with 302" do
        get :index
        # byebug
        expect(response).to have_http_status(302)
      end

      it "should be redirect to login" do
        get :index
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end
end
