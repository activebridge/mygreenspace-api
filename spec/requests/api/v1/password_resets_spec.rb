require 'spec_helper'

describe 'POST /v1/password_resets' do
  let(:user) { create(:user) }

  context 'success' do
    let(:request_params) {
      {
        email: user.email
      }
    }

    before do
      allow_any_instance_of(ResetPasswordService).to receive(:perform!)
      post "/v1/password_resets", request_params
    end

    it {
      expect(response_json).to eq(
        {
          'status'  => 'ok',
          'message' => 'Email sent with password reset instructions'
        }
      )
    }
  end

  context 'invalid email' do
    let(:request_params) {
      {
        email: 'invalid@email.com'
      }
    }

    before do
      post "/v1/password_resets", request_params
    end

    it {
      expect(response_json).to eq({
        'status'  => 'error',
        'message' => 'Email address not found'
      })
    }
  end
end

describe 'PUT /v1/password_resets/:id' do
  let(:token) { 'sometoken' }
  let!(:user) { create(:user, password: 'Password1',
                      password_confirmation: 'Password1',
                      reset_digest: token) }

  context 'resets the password' do
    let(:request_params) {
      {
        user: {
          password: '1234567',
          password_confirmation: '1234567'
        }
      }
    }

    before do
      put "/v1/password_resets/#{token}", request_params
    end

    it {
      expect(response_json).to eq(
        {
          'status'  => 'ok',
          'message' => 'Password has been reset'
        }
      )
    }
  end

  context 'invalid password' do
    let(:request_params) {
      {
        user: {
          password: '',
          password_confirmation: '1234567'
        }
      }
    }

    before do
      put "/v1/password_resets/#{token}", request_params
    end

    it { expect(response_json['status']).to eq 'error' }
  end

end
