class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :monetary_account_id
      t.float :amount
      t.text :description
      t.datetime :transaction_time
      t.text :type
      t.datetime :synced

      t.timestamps
    end
  end
end
