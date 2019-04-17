json.extract! user, :id, :email, :google_token, :google_refresh_token, :google_sheet_id, :created_at, :updated_at
json.url user_url(user, format: :json)
