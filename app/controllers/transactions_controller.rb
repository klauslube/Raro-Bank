class TransactionsController < ApplicationController
  before_action :authenticate_free_or_premium_user!
  before_action :fetch_transaction, only: %i[edit update]
  before_action :fetch_receiver, only: %i[create]

  def index
    @transactions = current_user.account.sender_transactions.order(created_at: :asc)
  end

  def new
    @transaction = Transaction.new
    @receiver_cpf = params[:receiver_cpf]
  end

  def edit; end

  def create
    return redirect_to edit_transaction_path(@transaction), notice: t('.success') if @transaction.save

    render :new
  end

  def update
    if token_authenticated? && @transaction.update(transaction_params)
      @transaction.sender.balance -= @transaction.amount
      @transaction.sender.save! && @transaction.update(status: 'pending')

      @transaction.call_update_balance
      @transaction.update(status: 'completed')
      @transaction.notification_completed_transaction

      redirect_to transactions_path, notice: t('.success')
    else
      render :edit
    end
  end

  def resend_email
    @transaction = Transaction.find(params[:id])
    @transaction.resend_email
  end

  private

  def token_authenticated?
    token = Token.find_by(code: params[:transaction][:token_code], active: true)
    if @transaction.token.code == token&.code
      true
    else
      @transaction.errors.add(:token_code, t('.invalid_token'))
      false
    end
  end

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
