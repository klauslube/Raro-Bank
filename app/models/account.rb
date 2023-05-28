class Account < ApplicationRecord
  validates :balance, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
end
