class User < ApplicationRecord
  has_one :account, dependent: :destroy
  belongs_to :classroom, optional: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable

  has_many :user_investments, dependent: :destroy

  enum :role, {
    free: 1,
    premium: 2,
    admin: 3
  }, scopes: true, default: :free

  validates :name, :cpf, :email, :password, presence: true
  validates :cpf, length: { is: 11 }, uniqueness: true, numericality: { only_integer: true }
  validates :name, length: { minimum: 3, maximum: 255 }
  validates :cpf, length: { is: 11 }

  validate :strong_password

  scope :by_cpf, ->(cpf) { where(cpf:) }
  scope :by_name, ->(name) { where(name:) }
  scope :name_contains, ->(contain) { where('name ILIKE ?', "%#{contain}%") }
  scope :unconfirmed_email, -> { where(confirmed_at: nil) }
  scope :confirmed_email, -> { where.not(confirmed_at: nil) }

  after_create :create_account
  before_destroy :check_if_last_admin

  private

  def strong_password
    return if password.blank?

    errors.add(:password, :no_letter) unless password =~ /[a-zA-Z]/
    errors.add(:password, :no_number) unless password =~ /\d/
    errors.add(:password, :no_special) unless password =~ /[!@#$%^&*()\-_=+{};:,<.>]/
  end

  def check_if_last_admin
    return unless role == 'admin' && User.admin.count == 1

    errors.add(:base, 'Cannot delete the last admin user.')
    throw(:abort)
  end

  def create_account
    build_account(balance: 0).save
  end
end
