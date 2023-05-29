class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.decimal :amount, precision: 9, scale: 2, null: false
      t.integer :status, default: 1, null: false
      t.string :token, null: false

      t.timestamps
    end
  end
end
