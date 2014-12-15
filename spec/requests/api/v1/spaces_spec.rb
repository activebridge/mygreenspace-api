require 'spec_helper'

describe 'GET /v1/users/:id/spaces/:id' do
  let(:user) { create(:user) }
  let!(:access_token) { create(:access_token, resource_owner_id: user.id) }
  let(:space) { create(:space, user: user) }
  let(:request_params) {
    {
      access_token: access_token.token
    }
  }

  context 'returns a space by :id' do
    before do
      get "/v1/users/#{user.id}/spaces/#{space.id}", request_params
    end

    it 'returns a space by :id' do
      expect(response_json).to eq(
        {
          'id'            => space.id,
          'width'         => space.width,
          'length'        => space.length,
          'created_at'    => space.created_at.as_json,
          'updated_at'    => space.updated_at.as_json
        }
      )
    end
  end

  context 'authentication failed' do
    let(:request_params) {
      {
        access_token: ''
      }
    }

    before do
      get "/v1/users/#{user.id}/spaces/#{space.id}", request_params
    end

    it { expect(response.body).to be_blank }
    it { expect(response.headers["WWW-Authenticate"]).to eq %(Bearer realm="Doorkeeper", error="invalid_token", error_description="The access token is invalid") }
  end

  context 'invalid space id' do
    let(:space_2) { FactoryGirl.create(:space) }

    it {
      expect {
        get "/v1/users/#{user.id}/spaces/#{space_2.id}", request_params
      }.to raise_error ActiveRecord::RecordNotFound
    }
  end
end

describe 'GET /v1/users/:id/spaces' do
  let(:user) { create(:authenticated_user) }
  let!(:space_1) { create(:space, user: user) }
  let!(:space_2) { create(:space, user: user) }
  let!(:space_3) { create(:space) }

  before do
    get '/v1/users/:id/spaces', { access_token: user.token }
  end

  it 'retrives all spaces' do
    expect(response_json['spaces']).to eq([
      {
        'id'          => space_1.id,
        'created_at'  => space_1.created_at.as_json,
        'updated_at'  => space_1.updated_at.as_json,
        'user_id'     => space_1.user_id
      },
      {
        'id'          => space_2.id,
        'created_at'  => space_2.created_at.as_json,
        'updated_at'  => space_2.updated_at.as_json,
        'user_id'     => space_2.user_id
      }
    ])
  end
end

describe 'POST /v1/users/:id/spaces' do
  let(:user) { create(:authenticated_user) }
  let(:request_params) {
    {
      access_token: user.token,
      space: {
        width: 10,
        length: 20
      }
    }
  }

  before do
    post '/v1/users/:id/spaces', request_params
  end

  it {
    space = user.spaces.last
    expect(response_json).to eq(
      {
        'id'         => space.id,
        'width'      => 10,
        'length'     => 20,
        'created_at' => space.created_at.as_json,
        'updated_at' => space.updated_at.as_json
      }
    )
  }
end

describe 'PATCH /v1/users/:id/spaces/:id' do
  let(:user) { create(:authenticated_user) }
  let(:space) { create(:space, user: user, width: 10) }
  let(:request_params) {
    {
      access_token: user.token,
      space: {
        width: 20
      }
    }
  }

  before do
    patch "/v1/users/:id/spaces/#{space.id}", request_params
    space.reload
  end

  it { expect(space.width).to eq(20) }
end

describe 'DELETE /v1/users/:id/spaces/:id' do
  let(:user) { create(:authenticated_user) }
  let!(:space) { create(:space, user: user) }
  let(:request_params) {
    {
      access_token: user.token,
    }
  }

  it {
    expect {
      delete "/v1/users/:id/spaces/#{space.id}", request_params
    }.to change{ user.spaces.count }.from(1).to(0)
  }
end
