require 'spec_helper'

describe 'POST /oauth/token' do
  let(:user) { create(:user) }
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
