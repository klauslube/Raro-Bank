module Transactions
  class UpdateBalanceJob < ApplicationJob
    queue_as :transactions

    sidekiq_options retry: 5

    def perform(transaction_id)
      transaction = Transaction.find(transaction_id)
      Transactions::UpdateBalanceService.new(transaction).call
      schedule_next_business_day(transaction)
    end

    private

    def schedule_next_business_day(transaction)
      next_transfer_day = find_next_transfer_day
      next_transfer_time = next_transfer_day.beginning_of_day + 8.hours
      self.class.set(wait_until: next_transfer_time).perform_later(transaction.id)
    end

    def find_next_transfer_day
      current_day = Time.now.in_time_zone('America/Fortaleza').to_date
      next_day = current_day + 1.day
      next_day += 1.day until next_day.on_weekday?
      next_day
    end
  end
end
