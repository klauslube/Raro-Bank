class Transaction < ApplicationRecord
  belongs_to :sender, class_name: 'Account'
  belongs_to :receiver, class_name: 'Account'
  has_one :token, dependent: :destroy

  validates :token_code, presence: true
  validates :status, presence: { in: %i[started authenticated pending completed canceled] }
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :check_sender_balance
  validate :check_transfer_yourself

  after_create :generate_token
  after_create :token_countdown
  after_commit :update_balance
  after_commit :new_transfer

  enum :status, {
    started: 1,
    authenticated: 5,
    pending: 10,
    completed: 15,
    canceled: 20
  }, scopes: true, default: :started

  private

  def generate_token
    build_token(code: SecureRandom.random_number(1_000_000).to_s.rjust(6, '0').to_i).save
  end

  def token_countdown
    Transactions::TokenUpdateJob.set(wait: 5.minutes).perform_later
  end

  def check_sender_balance
    errors.add(:amount, 'Insufficient balance for the transaction') if sender.balance < amount.to_f
  end

  def check_transfer_yourself
    errors.add(:receiver_id, "You can't send a transaction to yourself") if receiver_id == sender_id
  end

  def update_balance
    Transactions::UpdateBalanceJob.perform_later(id)
  end

  def new_transfer
    TransactionMailer.notify(self).deliver_now
  end
end
