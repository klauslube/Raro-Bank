class ChangeTransactionColumnsOrder < ActiveRecord::Migration[7.0]
  def change
    change_column :transactions, :sender_id, :uuid, after: :token
    change_column :transactions, :receiver_id, :uuid, after: :sender_id
  end
end
