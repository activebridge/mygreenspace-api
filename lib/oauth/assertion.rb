module Oauth
  class Assertion
    def self.authenticate_with_facebook token
      user_data = self.fetch_data(token)
      User.find_or_create_by_social_provider(provider: 'facebook',
                                             provider_id: user_data['id'],
                                             email: user_data['email'],
                                             first_name: user_data['first_name'],
                                             last_name: user_data['last_name'])

    end

    private

    def self.fetch_data token
      facebook = URI.parse("https://graph.facebook.com/me?access_token=#{token}")
      response = Net::HTTP.get_response(facebook)
      JSON.parse(response.body)
    end
  end
end
