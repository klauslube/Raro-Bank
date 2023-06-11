module UserInvestments
  class UpdateProfitJob < ApplicationJob
    queue_as :investments

    def perform(user_investment_id)
      UserInvestments::UpdateProfitService.new(user_investment_id).call
    end
  end
end
