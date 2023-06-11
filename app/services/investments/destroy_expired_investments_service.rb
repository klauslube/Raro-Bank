module Investments
  class DestroyExpiredInvestmentsService
    def initialize(investment_id)
      @investment_id = investment_id
      @investment = Investment.find(@investment_id)
    end

    def call
      destroy_expired_investments
    end

    private

    def destroy_expired_investments
      return unless @investment.expiration_date < Date.current

      update_account_balance_before_destroy
      @investment.destroy
    end

    def update_account_balance_before_destroy
      @investment.user_investments.each(&:update_account_balance_after_rescue)
    end
  end
end
