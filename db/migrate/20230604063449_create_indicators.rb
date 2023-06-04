class CreateIndicators < ActiveRecord::Migration[7.0]
  def change
    create_table :indicators do |t|
      t.decimal :rate, precision: 9, scale: 6, null: false
      t.string :web_address, null: false
      
      t.timestamps
    end
  end
end
