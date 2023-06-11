class User < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[name email cpf role]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[classroom investment]
  end

  has_one :account, dependent: :destroy
  belongs_to :classroom, optional: true
  has_many :user_investments, dependent: :destroy
  has_many :investments, foreign_key: :approver_id, dependent: :nullify, inverse_of: :approver

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable

  delegate :balance, to: :account

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
  scope :all_except_current_user, ->(user) { where.not(id: user) }
  scope :all_except_admins, -> { where.not(role: :admin) }
  scope :name_contains, ->(contain) { where('name ILIKE ?', "%#{contain}%") }
  scope :unconfirmed_email, -> { where(confirmed_at: nil) }
  scope :confirmed_email, -> { where.not(confirmed_at: nil) }
  scope :approvers, -> { joins(:investments).where(investments: { approver_id: pluck(:id) }).distinct }

  after_create :create_account
  before_destroy :check_if_last_admin

  def check_if_last_admin
    return unless role == 'admin' && User.admin.count == 1

    errors.add(:notice, t('.last_admin'))
    throw(:abort)
  end

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
