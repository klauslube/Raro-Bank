module Admin
  class InvestmentsController < ApplicationController
    before_action :authenticate_admin!
    before_action :fetch_investment, only: %i[show destroy]

    def index
      @q = Investment.ransack(params[:q])
      @investments = @q.result(distinct: true).order(:minimum_amount).page(params[:page]).per(10)
    end

    def show; end

    def new
      @investment = Investment.new
      @approver_id = current_user.id
    end

    def create
      @investment = Investment.new(investment_params)

      return redirect_to admin_investment_url(@investment), notice: t('.success') if @investment.save

      render :new, status: :unprocessable_entity
    end

    def destroy
      @investment.destroy
      redirect_to admin_investments_path, notice: t('.success')
    end

    private

    def investment_params
      params.require(:investment).permit(:name, :minimum_amount, :indicator_id, :premium, :start_date, :expiration_date, :approver_id)
    end

    def fetch_investment
      @investment = Investment.find(params[:id])
    end
  end
end
