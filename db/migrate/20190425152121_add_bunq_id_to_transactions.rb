class AddBunqIdToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :bunq_id, :integer
  end
end
