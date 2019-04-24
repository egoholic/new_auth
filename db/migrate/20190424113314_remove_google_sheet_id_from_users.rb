class RemoveGoogleSheetIdFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :google_sheet_id, :string
  end
end
