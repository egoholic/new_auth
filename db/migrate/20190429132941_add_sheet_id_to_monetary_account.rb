class AddSheetIdToMonetaryAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :monetary_accounts, :sheet_id, :integer
  end
end
