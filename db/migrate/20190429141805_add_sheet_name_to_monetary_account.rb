class AddSheetNameToMonetaryAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :monetary_accounts, :sheet_name, :string
  end
end
