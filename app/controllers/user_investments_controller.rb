class UserInvestmentsController < ApplicationController
  before_action :authenticate_free_or_premium_user!
  before_action :fetch_user_investment, only: %i[show edit update destroy]

  def index
    @user_investments = UserInvestment.where(user_id: current_user.id)
  end

  def show; end

  def new
    @user_investment = UserInvestment.new
    @investments = Investment.all
  end

  def edit; end

  def create
    @user_investment = UserInvestment.new(user_investment_params)

    return redirect_to user_investments_path, notice: 'User investment was successfully created.' if @user_investment.save

    @investments = Investment.all
    render :new, status: :unprocessable_entity
  end

  def update
    return redirect_to investment_url(@user_investment), notice: 'User investment was successfully updated.' if @user_investment.update(investment_params)

    render :edit, status: :unprocessable_entity
  end

  def destroy
    @user_investment.destroy
    redirect_to user_investments_path, notice: 'User investment was successfully deleted.'
  end

  private

  def user_investment_params
    params.require(:user_investment).permit(:initial_amount, :user_id, :investment_id, :profit)
  end

  def fetch_user_investment
    @user_investment = UserInvestment.find(params[:id])
  end
end
