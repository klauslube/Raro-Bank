class AddIndexToTransactionsToken < ActiveRecord::Migration[7.0]
  def change
    add_index :transactions, :token, unique: true
  end
end
