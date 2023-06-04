module Admin
  class InvestmentsController < ApplicationController
    before_action :authenticate_admin!
    before_action :fetch_investment, only: %i[show edit update destroy]

    def index
      @investments = Investment.all
    end

    def show; end

    def new
      @investment = Investment.new
      @approver_id = current_user.id
    end

    def edit; end

    def create
      @investment = Investment.new(investment_params)

      return redirect_to admin_investment_url(@investment), notice: 'Investment was successfully created.' if @investment.save

      render :new, status: :unprocessable_entity
    end

    def update
      return redirect_to admin_investment_url(@investment), notice: 'Investment was successfully updated.' if @investment.update(investment_params)

      render :edit, status: :unprocessable_entity
    end

    def destroy
      @investment.destroy
      redirect_to admin_investment_path, notice: 'Investment was successfully deleted.'
    end

    private

    def investment_params
      params.require(:investment).permit(:name, :minimum_amount, :income, :premium, :profit, :expiration_date, :approver_id)
    end

    def fetch_investment
      @investment = Investment.find(params[:id])
    end
  end
end
