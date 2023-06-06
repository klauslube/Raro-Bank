class AddColumnDateToIndicator < ActiveRecord::Migration[7.0]
  def change
    add_column :indicators, :rate_date, :date
  end
end
