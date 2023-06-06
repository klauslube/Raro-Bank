class AddColumnToInvestments < ActiveRecord::Migration[7.0]
  def change
    add_column :investments, :start_date, :date, null: false, default: Date.today
  end
end
