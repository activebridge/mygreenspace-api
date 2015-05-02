FactoryGirl.define do
  sequence(:picture) { "https://robohash.org/my-own-slug.png?size=100x100" }

  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email      { Faker::Internet.email }
    password   'Password1'
    password_confirmation 'Password1'
    picture
    provider User::SignUpType::EMAIL
  end

  factory :authenticated_user, parent: :user do
    access_token factory: :access_token
  end
end
