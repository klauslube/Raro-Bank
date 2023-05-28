class Investiment < ApplicationRecord
  validates :name, presence: true, length: { minimum: 1, maximum: 15 }
  validates :minimum_amount, :profit, presence: true, numericality: { greater_than: 0 }
  validates :premium, :income, :expiration_date, presence: true
end
