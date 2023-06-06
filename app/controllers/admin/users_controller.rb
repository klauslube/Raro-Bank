module Admin
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :fetch_user, only: %i[edit update]
    before_action :fetch_admin, only: %i[edit_admin update_admin destroy_admin]
    before_action :check_if_is_the_last_admin, only: %i[destroy_admin]

    def index
      @users = User.all_except_current_user(current_user.id).order(:name)
    end

    def edit; end

    def update
      if @user.update_without_password(admin_user_params)
        redirect_to admin_users_path, notice: "Usuário atualizado com sucesso!"
      else
        render :edit, alert: "Não foi possível atualizar o usuário!", status: :unprocessable_entity
      end
    end

    def edit_admin; end

    def update_admin
      if @admin.update(admin_user_params)
        redirect_to admin_users_path, notice: "Usuário atualizado com sucesso!"
      else
        render :edit_admin, alert: "Não foi possível atualizar o usuário!"
      end
    end

    def destroy_admin
      if current_user.destroy
        redirect_to root_path, notice: "Usuário administrador excluído com sucesso!"
      else
        render :edit_admin, alert: "Não foi possível excluir o usuário administrador."
      end
    end

    private

    def admin_user_params
      params.require(:user).permit(:classroom_id, :role, :name, :cpf, :email, :password, :password_confirmation)
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

      redirect_to root_path, alert: "Não é possível excluir o último usuário administrador."
    end
  end
end
