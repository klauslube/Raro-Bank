class Classroom < ApplicationRecord
  has_many :users, dependent: :restrict_with_error, after_add: :upgrade_user_role

  validates :name, :start_date, :end_date, presence: true
  validates :name, uniqueness: true, length: { minimum: 3, maximum: 100 }

  validate :end_date_after_start_date

  scope :with_users, -> { joins(:users).distinct }
  scope :by_name, ->(name) { where(name:) }
  scope :name_contains, ->(contain) { where('name ILIKE ?', "%#{contain}%") }
  scope :active, -> { where('start_date <= ? AND end_date >= ?', Time.zone.today, Time.zone.today) }
  scope :inactive, -> { where('start_date > ? OR end_date < ?', Time.zone.today, Time.zone.today) }

  private

  def end_date_after_start_date
    return unless start_date && end_date

    errors.add(:end_date, :end_date_after) if end_date < start_date
  end

  def upgrade_user_role(user)
    user.update(role: :premium) unless user.premium?
  end
end
