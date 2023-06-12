module Investments
  class DestroyExpiredInvestmentsJob < ApplicationJob
    queue_as :investments

    def perform(investment_id)
      Investments::DestroyExpiredInvestmentsService.new(investment_id).call
    end
  end
end
