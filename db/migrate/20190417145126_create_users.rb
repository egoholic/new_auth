class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :google_token
      t.string :google_refresh_token
      t.string :google_sheet_id

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
