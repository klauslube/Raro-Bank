class AddUserToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_reference :accounts, :user, foreign_key: { to_table: :users }, type: :uuid
  end
end
