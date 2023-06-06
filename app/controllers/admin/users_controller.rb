module Admin
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :fetch_user, only: %i[edit update]

    def index
      @users = User.all_except_admins.order(:name)
    end

    def edit; end

    def update
      if @user.update_without_password(admin_user_params)
        redirect_to admin_users_path, notice: 'Usuário atualizado com sucesso!'
        render :edit, alert: 'Não foi possível atualizar o usuário!', status: :unprocessable_entity
      end
    end

    private

    def admin_user_params
      params.require(:user).permit(:classroom_id, :role, :name, :cpf, :email)
    end

    def fetch_user
      @user = User.find_by(id: params[:user_id]) if params[:user_id]
      @user = User.find_by(id: params[:id]) if params[:id]
    end
  end
end
