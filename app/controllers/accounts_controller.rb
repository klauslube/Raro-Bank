class AccountsController < ApplicationController
  before_action :authenticate_free_or_premium_user!

  def index; end

  # def show; end

  # def new; end

  # def edit; end

  # def create; end

  # def update; end

  # def destroy; end
end
