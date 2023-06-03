require "rails_helper"

RSpec.describe HomeController, type: :controller do
  context "Unauthenticated" do
    it "should raise error: not free or premium user" do
        allow(controller).to receive(:authenticate_free_or_premium_user!).and_raise(StandardError.new("not_a_free_or_premium_user"))

        expect { get :index }.to raise_error(StandardError, "not_a_free_or_premium_user")
    end

    before :each do
      get :index
    end

    it 'should respond with 302' do
      expect(response).to have_http_status(302)
    end

    it 'should redirect to login' do
      expect(response).to redirect_to('/')
    end
  end

  describe "#index" do
    context "Authenticated as free user" do
      let(:user) { create(:user_confirmed) }

      before do
        sign_in user
        get :index
      end

      it "should respond with 200" do
        expect(response).to have_http_status(200)
      end

      it "should render index template" do
        expect(response).to render_template(:index)
      end
    end

    context "Authenticated as premium user" do
      let(:user) { create(:user_confirmed, :premium) }

      before do
        sign_in user
        get :index
      end

      it "should respond with 200" do
        expect(response).to have_http_status(200)
      end

      it "should render index template" do
        expect(response).to render_template(:index)
      end
    end

    context "Unauthorized as admin user" do
      let(:admin) { create(:user, :admin) }

      before do
        sign_in admin
        get :index
      end

      it "should respond with 302" do
        expect(response).to have_http_status(302)
      end

      it "should be redirect to login" do
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end
end
