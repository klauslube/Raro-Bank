class Transaction < ApplicationRecord
  belongs_to :sender, class_name: 'Account'
  belongs_to :receiver, class_name: 'Account'
  has_one :token, dependent: :destroy

  validates :status, presence: { in: %i[started authenticated pending completed canceled] }
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :check_sender_balance
  validate :check_transfer_yourself

  scope :sent_by_admins, -> { joins(:sender).merge(Account.admins) }

  after_create :generate_token
  after_create :token_countdown
  after_create :cancel_transfer_countdown
  after_commit :send_confirmation_email, on: :create
  after_commit :send_notification_email, on: :create

  enum :status, {
    started: 1,
    authenticated: 5,
    pending: 10,
    completed: 15,
    canceled: 20
  }, scopes: true, default: :started

  def resend_email
    send_confirmation_email
  end

  def save_without_token!
    self.status = :authenticated
    save!
  end

  def call_update_balance
    update_balance
  end

  def self.within_transfer_hours?
    current_time = Time.now.in_time_zone('America/Fortaleza')
    weekday = current_time.wday
    hour = current_time.hour
    weekday >= 1 && weekday <= 5 && hour >= 8 && hour < 18
  end

  def notification_completed_transaction
    receiver_notification_email
  end

  private

  def generate_token
    loop do
      new_code = rand(100_000..999_999)
      if Token.tokens_actives.where(code: new_code).blank?
        build_token(code: new_code).save
        break
      end
    end
  end

  def token_countdown
    return if sender.user.admin?

    Transactions::TokenUpdateJob.set(wait: 5.minutes).perform_later
  end

  def cancel_transfer_countdown
    return if sender.user.admin?

    Transactions::CancelTransferJob.set(wait: 6.minutes).perform_later(id)
  end

  def check_sender_balance
    errors.add(:amount, :insufficient_balance) if sender.balance < amount.to_f
  end

  def check_transfer_yourself
    errors.add(:receiver_id, :transfer_yourself) if receiver_id == sender_id
  end

  def update_balance
    if self.class.within_transfer_hours?
      # Transactions::UpdateBalanceService.new(self).call
      Transactions::UpdateBalanceJob.perform_now(id)
    else
      Transactions::UpdateBalanceJob.perform_later(id)
    end
  end

  def send_confirmation_email
    TransactionMailer.token_confirmation(self).deliver_now unless sender.user.admin?
  end

  def send_notification_email
    TransactionMailer.transfer_notification(self).deliver_now unless sender.user.admin?
  end

  def receiver_notification_email
    TransactionMailer.receiver_notification(self).deliver_now unless sender.user.admin?
  end
end
