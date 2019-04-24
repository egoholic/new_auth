class RemoveGoogleRefreshTokenFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :google_refresh_token, :string
  end
end
