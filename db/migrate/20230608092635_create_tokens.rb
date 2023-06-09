class CreateTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :tokens do |t|
      t.integer :code, null: false, limit: 6
      t.boolean :active, default: true
      t.belongs_to :transaction, null: false, foreign_key: true

      t.timestamps
    end
  end
end
