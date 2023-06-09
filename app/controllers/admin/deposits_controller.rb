module Admin
  class DepositsController < ApplicationController
    before_action :fetch_amount, only: %i[create]
    before_action :fetch_classroom, only: %i[create fetch_classroom_users_accounts]
    before_action :fetch_classroom_users_accounts, only: %i[create]
    before_action :fetch_receivers, only: %i[create]

    def new
      @transaction = Transaction.new
    end

    def create
      errors = []

      @receivers.each do |receiver_account|
        transaction = Transaction.new(sender: current_user.account, receiver: receiver_account, amount: @amount, token: generate_token)
        errors << transaction.errors.full_messages.to_sentence unless transaction.save
      end

      if errors.empty?
        redirect_to admin_root_path, notice: t('.success')
      else
        flash[:alert] = t('.failure') + "- receiver: #{receiver_account} -" + errors.join(' ')
      end
    end

    private

    def generate_token
      SecureRandom.hex(10)
    end

    def fetch_classroom
      @classroom = Classroom.find_by(id: params[:transaction][:classroom_id])
    end

    def fetch_classroom_users_accounts
      return if @classroom.nil?

      @classroom_users = @classroom.users.map(&:account)
      return @classroom_users unless @classroom_users.empty?
    end

    def fetch_receivers
      @receivers = []

      if @classroom_users.present? && @classroom_users.size > 1
        @receivers = @classroom_users
      elsif params[:transaction][:receiver_cpf].present?
        receiver = fetch_receiver_by_cpf
        @receivers << receiver
      else
        redirect_to admin_deposits_path, alert: t('.receiver_error')
        nil
      end
    end

    def fetch_receiver_by_cpf
      receiver_cpf = params[:transaction][:receiver_cpf]
      receiver = User.find_by(cpf: receiver_cpf)&.account

      return receiver unless receiver.nil?

      redirect_to admin_deposits_path, alert: t('.cpf_error')
      nil
    end

    def fetch_amount
      @amount = params[:transaction][:amount].to_f

      return @amount unless @amount < 1

      redirect_to admin_deposits_path, alert: t('.amount_error')
    end
  end
end
