class Investment < ApplicationRecord
  belongs_to :approver, class_name: 'User'
  has_many :user_investments, class_name: 'UserInvestment', dependent: :destroy
  has_many :users, through: :user_investments

  validates :name, presence: true, length: { minimum: 1, maximum: 15 }
  validates :minimum_amount, :profit, presence: true, numericality: { greater_than: 0 }
  validates :income, :expiration_date, presence: true
  validates :premium, inclusion: [true, false]
end
