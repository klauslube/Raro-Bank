class Investment < ApplicationRecord
  belongs_to :approver, class_name: 'User'
  belongs_to :indicator
  has_many :user_investments, class_name: 'UserInvestment', dependent: :destroy
  has_many :users, through: :user_investments

  validates :name, presence: true, length: { minimum: 1, maximum: 15 }
  validates :minimum_amount, presence: true, numericality: { greater_than: 0 }
  validates :expiration_date, :start_date, presence: true
  validates :premium, inclusion: [true, false]

  scope :invested_users_count, lambda { |investment_id|
    joins(:user_investments)
      .where(id: investment_id)
      .select('investments.id, COUNT(user_investments.id) AS invested_users_count')
      .group('investments.id')
  }

  after_commit :destroy_expired_investments, on: :create

  def self.ransackable_attributes(_auth_object = nil)
    %w[name minimum_amount expiration_date premium]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[indicator user_investment]
  end

  private

  def expiration_date_after_start_date
    return unless start_date && expiration_date

    errors.add(:expiration_date, :end_date_after) if expiration_date < start_date
  end

  def destroy_expired_investments
    Investments::DestroyExpiredInvestmentsJob.set(wait_until: expiration_date.to_time).perform_later(id)
  end
end
