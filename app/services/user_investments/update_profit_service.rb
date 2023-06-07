module UserInvestments
  class UpdateProfitService
    def initialize(user_investment_id)
      @user_investment_id = user_investment_id
    end

    def call
      update_investment_profit
    end

    private

    def update_investment_profit
      investment = UserInvestment.find(@user_investment_id)
      profit = investment.initial_amount + (investment.initial_amount * investment.investment.indicator.rate)
      investment.update(profit:)
    end
  end
end
