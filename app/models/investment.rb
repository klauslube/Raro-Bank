class Investment < ApplicationRecord
  belongs_to :approver, class_name: 'User'
  belongs_to :indicator
  has_many :user_investments, class_name: 'UserInvestment', dependent: :destroy
  has_many :users, through: :user_investments

  validates :name, presence: true, length: { minimum: 1, maximum: 15 }
  validates :minimum_amount, presence: true, numericality: { greater_than: 0 }
  validates :expiration_date, :start_date, presence: true
  validates :premium, inclusion: [true, false]

  validate :end_date_after_start_date

  private

  def expiration_date_after_start_date
    return unless start_date && expiration_date

    errors.add(:expiration_date, :end_date_after) if expiration_date < start_date
  end
end
