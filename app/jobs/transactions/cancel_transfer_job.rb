module Transactions
  class CancelTransferJob < ApplicationJob
    queue_as :transactions

    def perform(transaction_id)
      transaction = Transaction.find_by(id: transaction_id)
      transaction.update(status: :canceled) if transaction&.started?
    end
  end
end
