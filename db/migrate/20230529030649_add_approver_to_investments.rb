class AddApproverToInvestments < ActiveRecord::Migration[7.0]
  def change
    add_reference :investments, :approver, foreign_key: { to_table: :users }, type: :uuid
  end
end