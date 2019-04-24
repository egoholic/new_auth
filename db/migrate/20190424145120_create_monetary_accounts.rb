class CreateMonetaryAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :monetary_accounts do |t|
      t.integer :account_id
      t.integer :user_id

      t.timestamps
    end
  end
end
