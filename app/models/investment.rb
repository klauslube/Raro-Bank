class Investment < ApplicationRecord
  belongs_to :approver, class_name: 'User'

  validates :name, presence: true, length: { minimum: 1, maximum: 15 }
  validates :minimum_amount, :profit, presence: true, numericality: { greater_than: 0 }
  validates :income, :expiration_date, presence: true
  validates :premium, inclusion: [true, false]
end
