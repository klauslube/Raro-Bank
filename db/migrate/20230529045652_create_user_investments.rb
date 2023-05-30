class CreateUserInvestments < ActiveRecord::Migration[7.0]
  def change
    create_table :user_investments do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :investment, null: false, foreign_key: true
      t.decimal :initial_amount, null: false, precision: 9, scale: 2

      t.timestamps
    end
  end
end
