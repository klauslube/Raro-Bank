module Transactions
  class UpdateBalanceService
    def initialize(transaction)
      @transaction = transaction
    end

    def call
      update_balance
    end

    private

    def update_balance
      transaction_sender.balance -= transaction_amount
      transaction_receiver.balance += transaction_amount
      transaction_sender.save!
      transaction_receiver.save!
    end

    def transaction_sender
      @transaction.sender
    end

    def transaction_receiver
      @transaction.receiver
    end

    def transaction_amount
      @transaction.amount
    end
  end
end
