json.extract! transaction, :id, :monetary_account_id, :amount, :description, :transaction_time, :transaction_type, :synced, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
