require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'

class SyncService
    OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
    APPLICATION_NAME = 'BunqSync'.freeze
    CREDENTIALS_PATH = './config/google_credentials.json'.freeze
    TOKEN_PATH = './config/google_token.yaml'.freeze
    SCOPE = 'https://www.googleapis.com/auth/spreadsheets'

  def initialize
    @spreadsheet_id = '1NjYcEkYiarO52jgoGuKlGoYTNb51dAZMicBkpzJM4go'
    @service = Google::Apis::SheetsV4::SheetsService.new
    @service.client_options.application_name = APPLICATION_NAME
    @service.authorization = authorize
  end

  def perform
    find_unsynced
    @transactions.each do |transaction|
      row = [create_params(transaction)]
      response = append_row(row, transaction)
      sync_record(transaction) if response.updates.updated_rows == 1 
      sleep 1
    end
  end
  
  private

  def authorize
    client_id = Google::Auth::ClientId.from_file(CREDENTIALS_PATH)
    token_store = Google::Auth::Stores::FileTokenStore.new(file: TOKEN_PATH)
    authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
    user_id = 'default'
    credentials = authorizer.get_credentials(user_id)
    if credentials.nil?
      url = authorizer.get_authorization_url(base_url: OOB_URI)
      puts 'Open the following URL in the browser and enter the ' \
           "resulting code after authorization:\n" + url
      code = gets
      credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code, base_url: OOB_URI
      )
    end
    credentials
  end

  def find_unsynced
    @transactions = Transaction.where(synced: nil)
  end

  def create_params(transaction)
    transaction_params = {
      id: transaction[:id],
      amount: transaction[:amount],
      description: transaction[:description],
      transaction_type: transaction[:transaction_type],
      time: transaction[:transaction_time].strftime("%F %T"),
      bunq_id: transaction[:bunq_id]
    }
    transaction_params.values.each_with_object([]) { |value, arr| arr << value.to_s } 
  end

  def append_row(row_data, transaction)
    range = "#{transaction.monetary_account.sheet_name}!A1"
    value_input_option = 'USER_ENTERED'
    value_range_object = Google::Apis::SheetsV4::ValueRange.new(values: row_data)
    response = @service.append_spreadsheet_value(
              @spreadsheet_id,
              range,
              value_range_object,
              value_input_option: value_input_option)
  end

  def sync_record(transaction)
    transaction.update_attribute(:synced, DateTime.now)
  end
end