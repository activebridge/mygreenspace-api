FactoryGirl.define do
  factory :access_token, class: Doorkeeper::AccessToken do
    token { Faker::Lorem.characters(20) }
  end
end
