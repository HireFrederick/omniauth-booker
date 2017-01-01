# Omniauth::Booker

* An omniauth strategy for Booker

## Usage

This gem may be used to generate an OAuth access_token and refresh_token for using Booker's API. See https://developers.booker.com for more info.

Add this line to your application's Gemfile:

    gem 'omniauth-frederick'

By default, this gem authorizes against Booker's API sandbox environment: https://apicurrent-app.booker.ninja/App/Admin/Login.aspx

When you are ready to use it in production, add `BOOKER_OMNIAUTH_BASE_URL = https://signin.booker.com` to your ENV

Example middleware configuration (shown for Rails):

```
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :booker, ENV['BOOKER_CLIENT_ID'], ENV['BOOKER_CLIENT_SECRET'], {
    scope: 'openid, profile, email, userinfo, offline_access merchant'
  }
end
```
