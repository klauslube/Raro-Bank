module Admin
  class InvestmentsController < ApplicationController
    before_action :authenticate_admin!

    def index
      @investments = Investment.all
    end
  end
end
