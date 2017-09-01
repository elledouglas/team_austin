# enable :sessions

CALLBACK_URL = "http://instagram.dev/oauth/callback"

Instagram.configure do |config|
  config.client_id = "CLIENT_ID"
  config.client_secret = "CLIENT_SECRET"
end
