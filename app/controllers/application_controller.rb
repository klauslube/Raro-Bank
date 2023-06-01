# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protected

  def authenticate_admin!
    return if current_user&.admin?

    flash[:alert] = :not_an_admin
    redirect_to root_path
  end

  def authenticate_free_user!
    return if current_user&.free?

    flash[:alert] = :not_a_free_user
    redirect_to root_path
  end

  def authenticate_premium_user!
    return if current_user&.premium?

    flash[:alert] = :not_a_premium_user
    redirect_to root_path
  end

  def authenticate_free_or_premium_user!
    return if current_user && (current_user.free? || current_user.premium?)

    flash[:alert] = :not_a_free_or_premium_user
    redirect_to root_path
  end
end
