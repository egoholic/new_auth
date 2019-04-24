Bunq.configure do |config|
  config.api_key = ENV['bunq_api_token']
  config.private_key = ENV['bunq_private_key']
  config.server_public_key = ENV['bunq_server_key']
  config.installation_token = ENV['bunq_installation_token']
end