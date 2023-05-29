class AddSenderAndReceiverToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_reference :transactions, :sender, foreign_key: { to_table: :accounts}, null: false, type: :uuid 
    add_reference :transactions, :receiver, foreign_key: { to_table: :accounts}, null: false, type: :uuid 
  end
end
