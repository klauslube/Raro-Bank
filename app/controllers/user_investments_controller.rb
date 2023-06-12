class UserInvestmentsController < ApplicationController
  before_action :authenticate_free_or_premium_user!
  before_action :fetch_user_investment, only: %i[show destroy]
  before_action :fetch_investment, only: %i[new create]

  SORT_OPTIONS = {
    'Nome (A-Z)' => 'name_asc',
    'Nome (Z-A)' => 'name_desc',
    'Valor minimo ↑' => 'minimum_amount_asc',
    'Valor minimo ↓' => 'minimum_amount_desc',
    'Data de início ↑' => 'start_asc',
    'Data de início ↓' => 'start_desc',
    'Data de Vencimento ↑' => 'expiration_date_asc',
    'Data de Vencimento ↓' => 'expiration_date_desc'
  }.freeze

  def index
    @q = UserInvestment.ransack(params[:q])
    @user_investments = @q.result(distinct: true).where(user_id: current_user.id)
  end

  def catalogs
    @q = Investment.ransack(params[:q])
    @investments = @q.result(distinct: true).order(sort_column).page(params[:page]).per(10)
  end

  def show; end

  def new
    if current_user.role == 'free' && @investment.premium?
      redirect_to catalogs_path, notice: t('.error')
    else
      @user_investment = UserInvestment.new
    end
  end

  def create
    @user_investment = UserInvestment.new(user_investment_params)
    @user_investment.user_id = current_user.id
    @user_investment.investment_id = params[:investment_id]

    if @user_investment.save
      @user_investment.update_account_balance

      redirect_to user_investments_path, notice: t('.success')
    else
      fetch_investment
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user_investment.update_account_balance_after_rescue if @user_investment.destroy

    redirect_to user_investments_path, notice: t('.success')
  end

  private

  def user_investment_params
    params.require(:user_investment).permit(:initial_amount, :user_id, :investment_id, :profit)
  end

  def fetch_investment
    @investment = Investment.find(params[:investment_id])
  end

  def fetch_user_investment
    @user_investment = UserInvestment.find(params[:id])
  end

  def sort_column
    case params[:sort]
    when 'minimum'
      "minimum_amount #{params[:direction]}"
    when 'expiration'
      "investments.expiration_date #{params[:direction]}"
    when 'start'
      "investments.expiration_date #{params[:direction]}"
    when 'name'
      "investments.#{params[:sort]} #{params[:direction]}"
    else
      'name ASC'
    end
  end
end
