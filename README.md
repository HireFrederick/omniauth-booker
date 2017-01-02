# Omniauth::Booker

* An omniauth strategy for Booker

## Usage

This gem may be used to generate an OAuth access_token and refresh_token for using Booker's API. See https://developers.booker.com for more info.

Add this line to your application's Gemfile:

    gem 'omniauth-booker'

By default, this gem authorizes against Booker's API sandbox environment: https://apicurrent-app.booker.ninja/App/Admin/Login.aspx

When you are ready to use it in production, add `BOOKER_OMNIAUTH_BASE_URL = https://signin.booker.com` to your ENV

### Example Middleware Configuration

```
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :booker, ENV['BOOKER_CLIENT_ID'], ENV['BOOKER_CLIENT_SECRET'], {
    scope: 'openid profile userinfo offline_access merchant'
  }
end
```

### Example Auth Hash

Here's an example of an authentication hash available in the callback by accessing `request.env["omniauth.auth"]`:

```
{
  'provider' => :booker,
  'uid' => 4508508,
  'info' => {
    'name' => 'First Last',
    'location_id' => 10257,
    'user_name' => 'myusername',
    'account_name' => 'myaccountname',
    'user_type' => 2, 
    'roles' => 'Spa User:Admin'
  }, 
  'credentials' => {
    'token' => 'the_access_token',
    'refresh_token' => 'the_refresh_token',
    'expires_at' => 1483319048,
    'expires' => true
  },
  'extra' => {}
}
```
