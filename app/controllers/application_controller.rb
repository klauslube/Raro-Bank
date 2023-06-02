class ApplicationController < ActionController::Base
  before_action :set_admin_authentication!
  layout :set_layout

  private

  def set_admin_authentication!
    :authenticate_admin! if admin_controller?
  end

  def set_layout
    return 'admin' if admin_controller?

    'application'
  end

  def admin_controller?
    controller_path.start_with?('admin/')
  end

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
    return if current_user&.free? || current_user&.premium?

    flash[:alert] = :not_a_free_or_premium_user
    redirect_to root_path
  end
end
