module UserInvestments
  class UpdateProfitService
    def initialize(user_investment_id)
      @user_investment_id = user_investment_id
      @user_investment = UserInvestment.find(@user_investment_id)
    end

    def call
      update_investment_profit
    end

    private

    def update_investment_profit
      @user_investment.reload
      return if Date.current <= @user_investment.created_at.to_date

      @user_investment.profit += @user_investment.profit * calculate_daily_profit
      @user_investment.save
    end

    def calculate_daily_profit
      total_return = scan_numbers_in_name(@user_investment.investment.name)
      @user_investment.investment.indicator.rate * (total_return / 100.0)
    end

    def scan_numbers_in_name(name)
      numbers = name.scan(/\d+(?:\.\d+)?/).map(&:to_f)
      numbers.sum
    end
  end
end
