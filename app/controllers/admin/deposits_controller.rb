module Admin
  class DepositsController < ApplicationController
    before_action :fetch_classroom, only: %i[create fetch_classroom_users_accounts]
    before_action :fetch_classroom_users_accounts, only: [:create]
    before_action :fetch_receivers, only: [:create]

    def new
      @transaction = Transaction.new
    end

    def create
      amount = params[:transaction][:amount].to_f
      sender = current_user.account
      errors = []

      @receivers.each do |receiver|
        add_admin_balance(amount)
        transaction = Transaction.new(sender:, receiver:, amount:)
        errors << transaction.errors.full_messages.to_sentence unless transaction.save_without_token!
      end

      if errors.empty?
        redirect_to admin_deposits_path, notice: t('.success')
      else
        flash[:alert] = t('.failure') + "- receiver: #{receiver} -" + errors.join(' ')
        redirect_to admin_deposits_path
      end
    end

    private

    def fetch_classroom
      @classroom = Classroom.find_by(id: params[:transaction][:classroom_id])
    end

    def fetch_classroom_users_accounts
      return if @classroom.nil?

      @classroom_users = @classroom.users.map(&:account)
    end

    def fetch_receivers
      @receivers = []

      if @classroom_users.present? && @classroom_users.size.positive?
        @receivers = @classroom_users
      elsif params[:transaction][:receiver_cpf].present?
        receiver = fetch_receiver_by_cpf
        @receivers << receiver if receiver
      else
        redirect_to admin_deposits_path, alert: t('.receiver_error')
      end
    end

    def fetch_receiver_by_cpf
      receiver_cpf = params[:transaction][:receiver_cpf]
      receiver = User.find_by(cpf: receiver_cpf)&.account

      redirect_to admin_deposits_path, alert: t('.cpf_error') unless receiver

      receiver
    end

    def add_admin_balance(amount)
      current_user.account.update(balance: amount)
    end
  end
end
