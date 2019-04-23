class AddBunqToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :bunq_token, :string
    add_column :users, :string, :string
  end
end
