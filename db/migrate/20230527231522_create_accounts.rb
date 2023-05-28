class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :accounts, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.decimal :balance, precision: 9, scale: 2, null: false

      t.timestamps
    end
  end
end
