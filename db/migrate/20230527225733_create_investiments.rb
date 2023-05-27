class CreateInvestiments < ActiveRecord::Migration[7.0]
  def change
    create_table :investiments do |t|
      t.string :name
      t.decimal :minimum_amount
      t.decimal :income
      t.boolean :premium
      t.decimal :profit
      t.date :expiration_date

      t.timestamps
    end
  end
end
