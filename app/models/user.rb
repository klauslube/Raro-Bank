class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable

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

  private

  def strong_password
    return if password.blank?

    errors.add(:password, :no_letter) unless password =~ /[a-zA-Z]/
    errors.add(:password, :no_number) unless password =~ /\d/
    errors.add(:password, :no_special) unless password =~ /[!@#$%^&*()\-_=+{};:,<.>]/
  end
end
