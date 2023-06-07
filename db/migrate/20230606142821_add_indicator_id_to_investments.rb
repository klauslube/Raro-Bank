class AddIndicatorIdToInvestments < ActiveRecord::Migration[7.0]
  def change
    add_reference :investments, :indicator, null: false, foreign_key: true
  end
end
