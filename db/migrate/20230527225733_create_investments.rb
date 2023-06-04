class CreateInvestments < ActiveRecord::Migration[7.0]
  def change
    create_table :investments do |t|
      t.string :name, null: false, limit: 30
      t.decimal :minimum_amount, null:false, precision: 9, scale: 2
      t.decimal :income, null: false, precision: 9, scale: 4
      t.boolean :premium, null: false, default: false
      t.decimal :profit, null: true, precision: 9, scale: 2
      t.date :expiration_date, null: false

      t.timestamps
    end
  end
end
