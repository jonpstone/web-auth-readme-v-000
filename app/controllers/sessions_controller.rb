class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
      req.params['client_id'] = ENV['N2WYVJZQK2RXLPR53ZOF4YUUTXTE1SOTZWF5QC5E2WRMF4EO']
      req.params['client_secret'] = ENV['Q10EOMXMG5Z2YJXC2ZPHHX2C0Q4DNY0VC5BHKKZV5HXFWOPJ']
      req.params['grant_type'] = 'authorization_code'
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['code'] = params[:code]
    end

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end
