class RemoveBunqTokenFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :bunq_token, :string
  end
end
