class RemoveTokenAndAddTokenCodeToTransactions < ActiveRecord::Migration[7.0]
  def change
    remove_column :transactions, :token
    add_column :transactions, :token_code, :integer, limit: 6
  end
end
