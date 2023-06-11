require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      render plain: 'Hello World'
    end
  end

  describe '#set_admin_authentication!' do
    context 'when admin controller' do
      before { allow(controller).to receive(:admin_controller?).and_return(true) }
      let (:user) { create(:user, role: :admin) }

      it 'should calls authenticate admin' do
        sign_in user
        get :index
        expect(controller.send(:set_admin_authentication!)).to eq(:authenticate_admin!)
      end
    end

    context 'when not admin controller' do
      before { allow(controller).to receive(:admin_controller?).and_return(false) }

      it 'should not calls authenticate admin' do
        get :index
        expect(controller.send(:set_admin_authentication!)).not_to eq(:authenticate_admin!)
      end
    end
  end

  describe '#set_layout' do
    context 'when admin controller' do
      before { allow(controller).to receive(:admin_controller?).and_return(true) }

      it 'should returns the admin layout' do
        get :index
        expect(controller.send(:set_layout)).to eq('admin')
      end
    end

    context 'when not an admin controller' do
      before { allow(controller).to receive(:admin_controller?).and_return(false) }

      it 'should returns the application layout' do
        get :index
        expect(controller.send(:set_layout)).to eq('application')
      end
    end
  end

  describe '#admin_controller?' do
    context 'when controller path starts with admin/' do
      before { allow(controller).to receive(:controller_path).and_return('admin/users') }

      it 'should returns true' do
        expect(controller.send(:admin_controller?)).to be true
      end
    end

    context 'when controller path does not start with admin/' do
      before { allow(controller).to receive(:controller_path).and_return('users') }

      it 'should returns false' do
        expect(controller.send(:admin_controller?)).to be false
      end
    end
  end

  describe '#authenticate_user!' do
    controller(ApplicationController) do
      before_action :authenticate_user!

      def index
        render plain: 'Hello World'
      end
    end

    context 'when current user is signed in' do
      let(:user) { create(:user_confirmed) }

      before :each do
        sign_in user
        get :index
      end

      it 'should respond status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'should does not redirect' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when current user is not signed in' do
      before :each do
        get :index
      end

      it 'should redirects to new_user_session_path' do
        expect(response).to redirect_to('/users/sign_in')
      end

      xit 'should sets the flash alert message' do
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
      end

      it 'should redirect do home ' do
        get :index
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe '#authenticate_admin!' do
    controller(ApplicationController) do
      before_action :authenticate_admin!

      def index
        render plain: 'Hello World'
      end
    end

    context 'when current user is an admin' do
      let(:admin) { create(:user_confirmed, role: :admin) }

      it 'should does not redirect' do
        sign_in admin
        get :index
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when current user is not an admin' do
      let(:user) { create(:user_confirmed) }

      before :each do
        sign_in user
        get :index
      end

      it 'should redirects to root_path' do
        expect(response).to redirect_to('/')
      end

      it 'should sets the flash alert message' do
        expect(flash[:alert]).to eq(:not_an_admin)
      end
    end
  end

  describe '#authenticate_free_user!' do
    controller(ApplicationController) do
      before_action :authenticate_free_user!

      def index
        render plain: 'Hello World'
      end
    end

    context 'when current user is a free user' do
      let(:user) { create(:user_confirmed, role: :free) }

      before :each do
        sign_in user
        get :index
      end

      it 'should does not redirect' do
        expect(response).to have_http_status(:ok)
      end

      it 'should does not redirects to root_path' do
        expect(response).not_to redirect_to('/')
      end
    end

    context 'when current user is not a free user' do
      let(:user) { create(:user_confirmed, role: :premium) }

      before :each do
        sign_in user
        get :index
      end

      it 'should respond status 302' do
        expect(response).not_to have_http_status(:ok)
        expect(response).to have_http_status(302)
      end

      it 'should redirects to root_path' do
        expect(response).to redirect_to('/')
      end

      it 'should sets the flash alert message' do
        expect(flash[:alert]).to eq(:not_a_free_user)
      end
    end
  end

  describe '#authenticate_premium_user!' do
    controller(ApplicationController) do
      before_action :authenticate_premium_user!

      def index
        render plain: 'Hello World'
      end
    end

    context 'when current user is a premium user' do
      let(:user) { create(:user_confirmed, role: :premium) }

      before :each do
        sign_in user
        get :index
      end

      it 'should does not redirect' do
        expect(response).to have_http_status(:ok)
      end

      it 'should does not redirects to root_path' do
        expect(response).not_to redirect_to('/')
      end
    end

    context 'when current user is not a premium user' do
      let(:user) { create(:user_confirmed, role: :free) }

      before do
        sign_in user
        get :index
      end

      it 'should respond status 302' do
        expect(response).not_to have_http_status(:ok)
        expect(response).to have_http_status(302)
      end

      it 'should redirects to root_path' do
        expect(response).to redirect_to('/')
      end

      it 'should sets the flash alert message' do
        expect(flash[:alert]).to eq(:not_a_premium_user)
      end
    end
  end

  describe '#authenticate_free_or_premium_user!' do
    controller(ApplicationController) do
      before_action :authenticate_free_or_premium_user!

      def index
        render plain: 'Hello World'
      end
    end

    context 'when current user is a free user' do
      let(:user) { create(:user_confirmed, role: :free) }

      before :each do
        sign_in user
        get :index
      end

      it 'should does not redirect' do
        expect(response).to have_http_status(:ok)
      end

      it 'should does not redirects to root_path' do
        expect(response).not_to redirect_to('/')
      end
    end

    context 'when current user is a premium user' do
      let(:user) { create(:user_confirmed, role: :premium) }

      before :each do
        sign_in user
        get :index
      end

      it 'should does not redirect' do
        expect(response).to have_http_status(:ok)
      end

      it 'should does not redirects to root_path' do
        expect(response).not_to redirect_to('/')
      end
    end

    context 'when current user is a admin user' do
      let(:user) { create(:user_confirmed, role: :admin) }

      before :each do
        sign_in user
        get :index
      end

      it 'should redirect to home' do
        expect(response).to redirect_to('/')
      end

      it 'should respond status 302' do
        expect(response).not_to have_http_status(:ok)
        expect(response).to have_http_status(302)
      end
    end
  end
end
