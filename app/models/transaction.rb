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
end
