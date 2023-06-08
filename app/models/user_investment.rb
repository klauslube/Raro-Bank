class UserInvestment < ApplicationRecord
  belongs_to :user
  belongs_to :investment

  validates :initial_amount, presence: true, numericality: { greater_than: 0 }
  validate :initial_amount_enough?
  validate :premium_investment_available?
  # validate :balance_account_enough?

  after_commit :update_investment_profit, on: :create

  def update_account_balance
    # binding.break
    user.account.update(balance: user.account.balance - initial_amount)
  end

  private

  def update_investment_profit
    UserInvestments::UpdateProfitJob.perform_later(id)
  end

  def premium_investment_available?
    return unless user && user.role == 'free' && investment && investment.premium

    errors.add(:base, 'Premium investments are not available for free users')
  end

  def initial_amount_enough?
    errors.add(:initial_amount, 'needs to be more than minimum amount') if investment&.minimum_amount && initial_amount < investment.minimum_amount
  end

  def balance_account_enough?
    # binding.break
    errors.add(:base, 'Balance is not enough') if user.account.balance < initial_amount
  end
end
