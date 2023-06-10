class Token < ApplicationRecord
  belongs_to :transfer, class_name: 'Transaction', foreign_key: :transaction_id, dependent: :destroy, inverse_of: :token

  validates :code, presence: true

  scope :tokens_actives, -> { where(active: true) }
end
