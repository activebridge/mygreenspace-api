require 'spec_helper'

describe 'POST /oauth/token' do
  let(:user) { create(:user) }

  context 'returns access token' do
    let(:request_params) {
      {
        grant_type: 'password',
        email: user.email
      }
    }

    before do
      post "/oauth/token", request_params
    end

    it { expect(response_json['access_token']).to be }
    it { expect(response_json['token_type']).to eq 'bearer' }
    it { expect(response_json.keys.count).to eq 2 }
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
end
