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
      total_return = scan_numbers_in_name(investment.investment.name)
      daily_return = investment.investment.indicator.rate + (total_return / 100.0)

      profit = investment.initial_amount + (investment.initial_amount * daily_return)
      investment.update(profit:)
    end

    def scan_numbers_in_name(name)
      numbers = name.scan(/\d+(?:\.\d+)?/).map(&:to_f)
      numbers.sum
    end
  end
end
