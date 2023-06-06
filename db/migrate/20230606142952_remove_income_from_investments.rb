class RemoveIncomeFromInvestments < ActiveRecord::Migration[7.0]
  def change
    remove_column :investments, :income, :decimal
  end
end
