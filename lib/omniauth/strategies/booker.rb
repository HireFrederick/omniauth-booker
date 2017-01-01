require 'omniauth-oauth2'
require 'jwt'

module OmniAuth
  module Strategies
    class Booker < OmniAuth::Strategies::OAuth2
      option :name, :booker

      option :client_options, {
        site: ENV['BOOKER_OMNIAUTH_BASE_URL'] || 'https://apicurrent.identity.booker.ninja',
        authorize_url: '/auth/connect/authorize',
        token_url: '/auth/connect/token'
      }

      uid { raw_info['sub'].to_i }

      info do
        {
          name: raw_info['name'],
          location_id: raw_info['location_id'].to_i,
          user_name: raw_info['user_name'],
          account_name: raw_info['account_name'],
          user_type: raw_info['user_type'].to_i,
          roles: raw_info['roles']
        }
      end

      def raw_info
        @raw_info ||= JWT.decode(access_token.token, nil, false)[0]
      end
    end
  end
end
