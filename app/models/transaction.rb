class Transaction < ApplicationRecord
  belongs_to :sender, class_name: 'Account'
  belongs_to :receiver, class_name: 'Account'

  validates :token, presence: true, uniqueness: true
  validates :status, presence: { in: %i[started authenticated pending completed canceled] }
  validates :amount, presence: true, numericality: { greater_than: 0 }

  enum :status, {
    started: 1,
    authenticated: 5,
    pending: 10,
    completed: 15,
    canceled: 20
  }, scopes: true, default: :started

  before_commit :check_sender_balance

  private

  def check_sender_balance
    errors.add(:amount, 'Insufficient balance for the transaction') if sender.balance < amount.to_f
  end
end
