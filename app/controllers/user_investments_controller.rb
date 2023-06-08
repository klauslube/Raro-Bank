class UserInvestmentsController < ApplicationController
  before_action :authenticate_free_or_premium_user!
  before_action :fetch_user_investment, only: %i[show edit update destroy]
  # before_action :fetch_investment, only: %i[new]

  def index
    @user_investments = UserInvestment.where(user_id: current_user.id)
    @investments = Investment.all
  end

  def show; end

  def new
    @investment = Investment.find(params[:investment_id])
    @user_investment = UserInvestment.new
    @balance = current_user.account.balance
  end

  def edit; end

  def create
    @user_investment = UserInvestment.new(user_investment_params)

    if @user_investment.save
      @user_investment.update_account_balance

      redirect_to user_investments_path, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    return redirect_to investment_url(@user_investment), notice: t('.success') if @user_investment.update(investment_params)

    render :edit, status: :unprocessable_entity
  end

  def destroy
    @user_investment.destroy
    redirect_to user_investments_path, notice: t('.success')
  end

  private

  def user_investment_params
    params.require(:user_investment).permit(:initial_amount, :user_id, :investment_id, :profit)
  end

  def fetch_user_investment
    @user_investment = UserInvestment.find(params[:id])
  end

  def fetch_investment
    @investment = Investment.find(params[:investment_id])
  end
end
