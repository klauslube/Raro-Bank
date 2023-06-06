class ChangeProfitAttributeToUserInvestment < ActiveRecord::Migration[7.0]
  def change
    remove_column :investments, :profit, :decimal, precision: 9, scale: 2, null: true
    add_column :user_investments, :profit, :decimal, precision: 9, scale: 2, null: false, after: :initial_amount, default: 0
  end
end
