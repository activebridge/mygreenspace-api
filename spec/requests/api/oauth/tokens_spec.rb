require 'spec_helper'

describe 'POST /oauth/token' do
  let(:password) { 'Password1' }
  let(:user) { create(:user, password: password,
                             password_confirmation: password) }

  context 'returns access token' do
    let(:request_params) {
      {
        grant_type: 'password',
        email: user.email,
        password: password
      }
    }

    before do
      post "/oauth/token", request_params
    end

    it { expect(response_json['access_token']).to be }
    it { expect(response_json['token_type']).to eq 'bearer' }
    it { expect(response_json.keys.count).to eq 2 }
  end

  context 'invalid password' do
    let(:request_params) {
      {
        grant_type: 'password',
        email: user.email,
        password: 'invalid'
      }
    }

    before do
      post "/oauth/token", request_params
    end

    it { expect(response_json['error']).to eq 'invalid_resource_owner' }
    it { expect(response_json['error_description']).to eq 'The provided resource owner credentials are not valid, or resource owner cannot be found' }
  end

  context 'returns an error' do
    let(:request_params) {
      {
        grant_type: 'client_credentials',
        client_id: '',
        client_secret: '',
        email: user.email
      }
    }

    before do
      post "/oauth/token", request_params
    end

    it { expect(response_json['error']).to eq 'invalid_client' }
    it { expect(response_json['error_description']).to eq 'Client authentication failed due to unknown client, no client authentication included, or unsupported authentication method.' }
  end

  context 'authentication via facebook' do
    let(:facebook_data) {
      {
        'id'         => 'some_facebook_id',
        'email'      => Faker::Internet.email,
        'first_name' => Faker::Name.first_name,
        'last_name'  => Faker::Name.last_name
      }
    }

    before do
      allow(Oauth::Assertion).to receive_messages(fetch_data: facebook_data)
    end

    context 'creates new user and returns access token' do
      let(:request_params) {
        {
          grant_type: 'assertion',
          assertion_type: 'facebook',
          facebook_access_token: Faker::Lorem.characters(20)
        }
      }

      it {
        expect {
          post "/oauth/token", request_params
        }.to change{ User.count }.from(0).to(1)
      }

      it 'returns token' do
        post "/oauth/token", request_params
        expect(response_json['access_token']).to be
      end

    end
  end
end
