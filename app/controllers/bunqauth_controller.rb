class BunqauthController < ApplicationController
  require 'httparty'

  def new
    @auth_link = "#{ENV["bunq_base_uri"]}?response_type=code&client_id=#{ENV["bunq_client_id"]}&redirect_uri=#{ENV["bunq_callback_uri"]}&state=200"
  end

  def redirect
    @authresponse = authenticate(params['code']) if !params['code'].nil? 
    if @authresponse.code == 200 
      current_user.bunq_token = @authresponse.parsed_response['access_token']
      current_user.save
      @message = 'Successfully connected with Bunq'
    else
      @message = "Connection failure, #{@authresponse.parsed_response}"
    end
  end

  private

  def authenticate(oauth_code)
    auth_uri = 'https://api.oauth.bunq.com/v1/token'

    HTTParty.post(auth_uri, query: {grant_type: 'authorization_code',
                                    code: oauth_code,
                                    redirect_uri: ENV['bunq_callback_uri'],
                                    client_id: ENV['bunq_client_id'],
                                    client_secret: ENV['bunq_client_secret']
                                }
                            )
  end
end

