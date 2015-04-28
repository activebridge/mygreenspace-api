require 'spec_helper'

describe 'GET /v1/users/:id' do
  context 'with valid user' do
    let!(:user) { create(:user) }
    let!(:access_token) { create(:access_token, resource_owner_id: user.id) }
    let(:request_params) {
      {
        access_token: access_token.token
      }
    }

    before do
      get "/v1/users/#{user.id}", request_params
    end

    it { expect(response_json).to eq({
        'id'         => user.id,
        'first_name' => user.first_name,
        'last_name'  => user.last_name,
        'email'      => user.email,
        'picture'    => user.picture,
        'created_at' => user.created_at.as_json,
        'updated_at' => user.updated_at.as_json
      })
    }
  end

  context 'with invalid user' do
    let(:id) { 'unexisting_user_id' }
    let!(:access_token) { create(:access_token, resource_owner_id: id) }
    let(:request_params) {
      {
        access_token: access_token.token
      }
    }

    it {
      expect {
        get "/v1/users/#{id}", request_params
      }.to raise_error ActiveRecord::RecordNotFound
    }
  end
end

describe 'GET /v1/users' do
  let!(:user_1) { create(:user) }
  let!(:user_2) { create(:user) }
  let!(:access_token) { create(:access_token, resource_owner_id: user_1.id) }
  let(:request_params) {
    {
      access_token: access_token.token
    }
  }

  before do
    get '/v1/users', request_params
  end

  it { expect(response_json['users']).to have(2).items }
  it { expect(response_json['users']).to eq([
      {
        'id'         => user_1.id,
        'created_at' => user_1.created_at.as_json,
        'updated_at' => user_1.updated_at.as_json
      },
      {
        'id'         => user_2.id,
        'created_at' => user_2.created_at.as_json,
        'updated_at' => user_2.updated_at.as_json
      }
    ])
  }
end

describe 'POST /v1/users' do
  context 'with valid params' do
    let(:email) { Faker::Internet.email }
    let(:first_name) { Faker::Name.first_name }
    let(:last_name) { Faker::Name.last_name }
    let(:request_params) {
      {
        user: {
          email: email,
          first_name: first_name,
          last_name: last_name,
        }
      }
    }

    before do
      post '/v1/users', request_params
    end

    it { expect(response_json['id']).to be }
    it { expect(response_json['email']).to eq email }
    it { expect(response_json['first_name']).to eq first_name }
    it { expect(response_json['last_name']).to eq last_name }
  end

  context 'with invalid params' do
    let!(:exisging_user) { create(:user) }
    let(:request_params) {
      {
        user: {
          first_name: '',
          email: exisging_user.email
        }
      }
    }

    before do
      post '/v1/users', request_params
    end

    it { expect(response_json).to eq(
      {
        'message' => 'Validation Failed',
        'errors' => [
          "First name can't be blank",
          "Last name can't be blank",
          "Email has already been taken"
        ]
      })
    }
  end
end

describe 'PATCH /v1/users/:id' do
  let!(:user) { create(:user) }
  let!(:access_token) { create(:access_token, resource_owner_id: user.id) }

  context 'with valid params' do
    let(:request_params) {
      {
        access_token: access_token.token,
        user: {
          first_name: 'John',
          last_name: 'Smith'
        }
      }
    }

    before do
      patch "/v1/users/#{user.id}", request_params
      user.reload
    end

    it { expect(user.first_name).to eq 'John' }
    it { expect(user.last_name).to eq 'Smith' }

    it { expect(response_json['id']).to be }
    it { expect(response_json['first_name']).to eq 'John' }
    it { expect(response_json['last_name']).to eq 'Smith' }
  end

  context 'with invalid params' do
    let!(:access_token) { create(:access_token, resource_owner_id: user.id) }
    let(:request_params) {
      {
        access_token: access_token.token,
        user: {
          first_name: ''
        }
      }
    }

    before do
      patch "/v1/users/#{user.id}", request_params
    end

    it { expect(response_json).to eq(
      {
        'message' => 'Validation Failed',
        'errors' => [
          "First name can't be blank"
        ]
      })
    }
  end
end

describe 'DELETE /v1/users/:id' do
  let!(:user) { create(:user) }
  let!(:access_token) { create(:access_token, resource_owner_id: user.id) }
  let(:request_params) {
    {
      access_token: access_token.token
    }
  }

  before do
    delete "/v1/users/#{user.id}", request_params
  end

  it { expect(User.count).to eq 0 }
  it { expect(response_json).to eq({ 'id' => user.id }) }
end
