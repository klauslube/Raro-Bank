module Admin
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :fetch_user, only: %i[edit update set_user_role]
    before_action :fetch_admin, only: %i[edit_admin update_admin destroy_admin]
    before_action :check_if_is_the_last_admin, only: %i[destroy_admin]

    def index
      @q = User.ransack(params[:q])
      @users = @q.result(distinct: true).all_except_current_user(current_user.id).order(:name).page(params[:page]).per(15)
    end

    def edit; end

    def update
      admin = params[:user][:role_admin] == '1'
      @user.role = admin ? 'admin' : set_user_role

      if @user.update_without_password(admin_user_params)
        redirect_to admin_users_path, notice: t('.success')
      else
        render :edit, alert: t('.failure'), status: :unprocessable_entity
      end
    end

    def edit_admin; end

    def update_admin
      if @admin.update_with_password(admin_user_params)
        redirect_to admin_users_path, notice: t('.success')
      else
        render :edit_admin, alert: t('.failure'), status: :unprocessable_entity
      end
    end

    def destroy_admin
      if current_user.destroy
        redirect_to root_path, notice: t('.success')
      else
        render :edit_admin, alert: t('.failure'), status: :unprocessable_entity
      end
    end

    private

    def admin_user_params
      params.require(:user).permit(:classroom_id, :role, :name, :cpf, :email, :password, :password_confirmation, :current_password, :role_admin)
    end

    def fetch_user
      @user = User.find_by(id: params[:user_id]) if params[:user_id]
      @user = User.find_by(id: params[:id]) if params[:id]
    end

    def fetch_admin
      @admin = User.find_by(id: current_user.id)
    end

    def check_if_is_the_last_admin
      return unless User.admin.count == 1

      redirect_to root_path, alert: t('.last_admin')
    end

    def set_user_role
      @user.classroom_id.nil? ? 'free' : 'premium'
    end
  end
end
