class RemoveGoogleTokenFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :google_token, :string
  end
end
