class AddNameToMonetaryAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :monetary_accounts, :name, :string
  end
end
