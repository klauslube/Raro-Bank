require 'rails_helper'
require 'ransack'
RSpec.describe Admin::UsersController, type: :controller do
  describe 'logged in as admin' do
    let(:admin) { create(:user_confirmed, role: :admin) }

    before :each do
      sign_in admin
    end

    context 'GET #index' do
      let(:user) { create(:user_confirmed) }
      let(:premium_user) { create(:user_confirmed, role: :premium) }

      before :each do
        get :index
      end

      it 'should assigns all users but current_user to @users' do
        expect(assigns(:users)).to match_array([user, premium_user])
      end

      it 'should respond with 200' do
        expect(response).to have_http_status(200)
      end

      it 'should renders the index template' do
        get :index
        expect(response).to render_template(:index)
      end

      it 'should not include current_user' do
        expect(assigns(:users)).not_to include(admin)
      end
    end

    context 'GET #edit' do
      let(:user) { create(:user_confirmed) }

      before :each do
        get :edit, params: { id: user.id }
      end

      it 'should assigns the requested user to @user' do
        expect(assigns(:user)).to eq(user)
      end

      it 'should respond with 200' do
        expect(response).to have_http_status(200)
      end

      it 'should renders the edit template' do
        expect(response).to render_template(:edit)
      end
    end

    context 'PATCH #update' do
      let(:user) { create(:user_confirmed) }

      context 'with valid parameters' do
        it 'should assigns the requested user to @user' do
          patch :update, params: { id: user.id, user: attributes_for(:user_confirmed) }

          expect(assigns(:user)).to eq(user)
        end

        it 'should update user' do
          patch :update, params: { id: user.id, user: attributes_for(:user_confirmed, name: 'New Name') }

          user.reload

          expect(user.name).to eq('New Name')
        end

        it 'should redirect to admin_users_path' do
          patch :update, params: { id: user.id, user: attributes_for(:user_confirmed) }

          expect(response).to redirect_to(admin_users_path)
        end

        xit 'should set flash[:notice]' do
          patch :update, params: { id: user.id, user: attributes_for(:user_confirmed) }

          expect(flash[:notice]).to eq('User updated successfully.')
        end
      end

      context 'with invalid parameters' do
        it 'should assigns the requested user to @user' do
          patch :update, params: { id: user.id, user: attributes_for(:user_confirmed, name: nil) }

          expect(assigns(:user)).to eq(user)
        end

        it 'should not update user' do
          old_name = user.name

          patch :update, params: { id: user.id, user: attributes_for(:user_confirmed, name: nil) }

          user.reload

          expect(user.name).to eq(old_name)
        end
      end
    end

    describe 'PATCH #update_admin' do
      let(:admin) { create(:user_confirmed, role: :admin) }

      context 'with valid parameters' do
        before :each do
          sign_in admin
          put :update_admin, params: { id: admin.id, user: { name: 'New Name', current_password: admin.password } }
        end

        it 'should updates the admin user' do
          expect(admin.reload.name).to eq('New Name')
        end

        it 'should redirect to admin_users_path' do
          expect(response).to redirect_to(admin_users_path)
        end

        xit 'should set flash[:notice]' do
          expect(flash[:notice]).to eq('Admin updated successfully.')
        end
      end

      context 'with invalid parameters' do
        before :each do
          put :update_admin, params: { id: admin.id, user: { name: nil } }
        end

        it 'should not update the admin user' do
          expect(admin.reload.name).not_to eq(nil)
        end

        it 'should render the edit template' do
          expect(response).to render_template(:edit_admin)
        end
      end
    end

    describe 'PATCH #destroy_admin' do
      context 'with valid parameters' do
        let(:current_user) { create(:user_confirmed, role: :admin) }
        let(:extra_user) { create(:user_confirmed, role: :admin) }

        before :each do
          sign_in current_user
          delete :destroy_admin, params: { id: current_user.id }
        end

        it 'should destroy the admin user' do
          expect(User.exists?(current_user.id)).to eq(false)
        end

        it 'should redirect to admin_users_path' do
          expect(response).to redirect_to(root_path)
        end

        xit 'should set flash[:notice]' do
          expect(flash[:notice]).to eq('Admin user deleted successfully.')
        end
      end

      context 'with invalid parameters' do
        let(:admin2) { create(:user_confirmed, role: :admin) }
        let(:extra_user) { create(:user_confirmed, role: :admin) }

        before :each do
          sign_in admin2
          delete :destroy_admin, params: { id: extra_user.id }
        end

        it 'should not destroy the admin user' do
          expect(User.exists?(extra_user.id)).to eq(true)
        end

        it 'should redirect to admin_users_path' do
          expect(response).to redirect_to(root_path)
        end
      end
    end

    describe '#fecth_user' do
      let(:user) { create(:user_confirmed) }

      it 'should assigns the requested user to @user' do
        get :edit, params: { id: user.id }

        expect(assigns(:user)).to eq(user)
      end
    end

    describe '#check_if_is_the_last_admin' do
      let(:current_user) { create(:user_confirmed, role: :admin) }

      context 'when there is more than one admin' do
        let(:extra_user) { create(:user_confirmed, role: :admin) }

        it 'should destroy the admin user' do
          sign_in current_user
          delete :destroy_admin, params: { id: current_user.id }

          expect(User.exists?(current_user.id)).to eq(false)
        end
      end

      context 'when there is only one admin' do
        it 'should not destroy the admin user' do
          sign_in admin
          delete :destroy_admin, params: { id: admin.id }

          expect(User.exists?(admin.id)).to eq(true)
        end
      end
    end
  end
end
