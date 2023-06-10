class Account < ApplicationRecord
  belongs_to :user
  has_many :sender_transactions, class_name: 'Transaction', foreign_key: :sender_id, dependent: :destroy, inverse_of: :sender
  has_many :receiver_transactions, class_name: 'Transaction', foreign_key: :receiver_id, dependent: :destroy, inverse_of: :receiver

  validates :balance, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  scope :not_admin, -> { joins(:user).where.not(users: { role: :admin }) }
end
