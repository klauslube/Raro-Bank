class HomeController < ApplicationController
  before_action :authenticate_free_or_premium_user!

  def index; end
end
