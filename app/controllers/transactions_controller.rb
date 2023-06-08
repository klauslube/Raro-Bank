class TransactionsController < ApplicationController
  before_action :authenticate_free_or_premium_user!
  before_action :fetch_transaction, only: %i[show]
  before_action :fetch_receiver, only: %i[create]

  def index
    @transactions = current_user.account.sender_transactions.order(created_at: :asc)
  end

  def show; end

  def new
    @transaction = Transaction.new
    @receiver_cpf = params[:receiver_cpf]
  end

  # def edit; end

  def create
    return redirect_to transactions_path, notice: t('.success') if @transaction.save

    render :new
  end

  # def update; end

  # def destroy; end

  private

  def transaction_params
    params.require(:transaction).permit(
      %i[amount status token_code sender_id receiver_id]
    )
  end

  def fetch_transaction
    @transaction = Transaction.find(params[:id])
  end

  def fetch_receiver
    @receiver_cpf = params[:transaction][:receiver_cpf]
    @receiver_account = User.find_by(cpf: @receiver_cpf)&.account
    adjust_accounts_ids
  end

  def adjust_accounts_ids
    adjusted_params = transaction_params.tap { |transaction| transaction[:receiver_id] = @receiver_account&.id }
    @transaction = current_user.account.sender_transactions.new(adjusted_params)
    @transaction.sender_id = current_user.account.id
  end
end
