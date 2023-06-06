class User < ApplicationRecord
  has_one :account, dependent: :destroy
  has_many :user_investments, dependent: :destroy
  belongs_to :classroom, optional: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable

  enum :role, {
    free: 1,
    premium: 2,
    admin: 3
  }, scopes: true, default: :free

  validates :name, :email, :cpf, presence: true
  validates :password, presence: true, on: :create
  validates :cpf, length: { is: 11 }, uniqueness: true, numericality: { only_integer: true }
  validates :name, length: { minimum: 3, maximum: 255 }

  validate :strong_password

  scope :by_cpf, ->(cpf) { where(cpf:) }
  scope :by_name, ->(name) { where(name:) }
  scope :by_email, ->(email) { where(email:) }
  scope :all_except_admins, -> { where.not(role: :admin) }
  scope :name_contains, ->(contain) { where('name ILIKE ?', "%#{contain}%") }
  scope :unconfirmed_email, -> { where(confirmed_at: nil) }
  scope :confirmed_email, -> { where.not(confirmed_at: nil) }

  after_create :create_account

  private

  def strong_password
    return if password.blank?

    errors.add(:password, :no_letter) unless password =~ /[a-zA-Z]/
    errors.add(:password, :no_number) unless password =~ /\d/
    errors.add(:password, :no_special) unless password =~ /[!@#$%^&*()\-_=+{};:,<.>]/
  end

  def create_account
    build_account(balance: 0).save
  end
end
