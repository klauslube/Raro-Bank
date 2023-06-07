class UserInvestment < ApplicationRecord
  belongs_to :user
  belongs_to :investment

  validates :initial_amount, presence: true, numericality: { greater_than: 0 }
  validate :initial_amount_enough?

  after_commit :update_investment_profit, on: :create

  private

  def update_investment_profit
    UserInvestments::UpdateProfitJob.perform_later(id)
  end

  def initial_amount_enough?
    errors.add(:initial_amount, 'needs to be more than minimum amount') if initial_amount < investment.minimum_amount
  end
end
