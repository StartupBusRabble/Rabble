class TokensController < ApplicationController

  def create
    grant = Twilio::JWT::AccessToken::ChatGrant.new
    grant.service_sid = ENV['IPM_SERVICE_SID']

    token = Twilio::JWT::AccessToken.new(
      ENV['ACCOUNT_SID'],
      ENV['API_KEY_SID'],
      ENV['API_KEY_SECRET'],
      [grant],
      identity: current_user.email
    )

    render json: {username: current_user.email, token: token.to_jwt}
  end
end
