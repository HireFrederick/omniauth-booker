require 'spec_helper'

describe OmniAuth::Strategies::Booker do
  let(:booker) { OmniAuth::Strategies::Booker.new('client_id', 'client_secret') }
  let(:raw_info) { {
    'name' => 'First Last',
    'sub' => '123456',
    'location_id' => '5678',
    'user_name' => 'flast',
    'account_name' => 'flastbusiness',
    'user_type' => '2',
    'roles' => 'Spa User:Admin'
  } }

  describe '.options' do
    it 'has the correct options by default' do
      expect(booker.options.client_options.site).to eq 'https://apicurrent.identity.booker.ninja'
      expect(booker.options.client_options.authorize_url).to eq '/auth/connect/authorize'
      expect(booker.options.client_options.token_url).to eq '/auth/connect/token'
    end

    context "ENV['BOOKER_OMNIAUTH_BASE_URL'] exists" do
      before do
        ENV['BOOKER_OMNIAUTH_BASE_URL'] = 'https://signin.booker.com'
        OmniAuth::Strategies.send(:remove_const, 'Booker')
        load 'omniauth/strategies/booker.rb'
      end

      after do
        ENV['BOOKER_OMNIAUTH_BASE_URL'] = nil
        OmniAuth::Strategies.send(:remove_const, 'Booker')
        load 'omniauth/strategies/booker.rb'
      end

      it 'sets the site url based on ENV' do
        expect(booker.options.client_options.site).to eq 'https://signin.booker.com'
      end
    end
  end

  describe '#info' do
    before do
      expect(booker).to receive(:raw_info).exactly(6).times.and_return(raw_info)
    end

    it 'maps the raw_info things to info' do
      expect(booker.info).to eq({
        name: raw_info['name'],
        location_id: raw_info['location_id'].to_i,
        user_name: raw_info['user_name'],
        account_name: raw_info['account_name'],
        user_type: raw_info['user_type'].to_i,
        roles: raw_info['roles']
      })
    end
  end

  describe '#uid' do
    before do
      expect(booker).to receive(:raw_info).and_return(raw_info)
    end

    it 'maps the raw_info id to uid' do
      expect(booker.uid).to eq raw_info['sub'].to_i
    end
  end

  describe '#raw_info' do
    let(:access_token) { instance_double('OAuth2::AccessToken', options: {}, token: jwt_token) }
    let(:jwt_token) { 'jwt token' }

    before do
      expect(booker).to receive(:access_token).and_return(access_token)
      expect(JWT).to receive(:decode).with(jwt_token, nil, false).and_return [raw_info]
    end

    it 'parses raw_info from the JWT token' do
      expect(booker.raw_info).to eq raw_info
    end
  end
end
