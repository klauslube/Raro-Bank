module Admin
  class TransactionsController < ApplicationController
    before_action :fetch_receiver, only: %i[create]
    before_action :fetch_amount, only: %i[create]

    def new
      @transaction = Transaction.new
    end

    def create
      transaction = Transaction.new(sender: current_user.account, receiver: @receiver, amount: @amount, token: generate_token)

      if transaction.save
        redirect_to root_path, notice: t('.success')
      else
        redirect_to admin_deposits_path, alert: t('.failure')
      end
    end

    private

    def generate_token
      SecureRandom.hex(10)
    end

    def fetch_receiver
      receiver_cpf = params[:transaction][:receiver_cpf]
      @receiver = User.find_by(cpf: receiver_cpf)&.account

      return @receiver unless @receiver.nil?

      redirect_to admin_deposits_path, alert: t('.cpf_error')
    end

    def fetch_amount
      @amount = params[:transaction][:amount].to_f

      return @amount unless @amount < 1

      redirect_to admin_deposits_path, alert: t('.amount_error')
    end
  end
end
