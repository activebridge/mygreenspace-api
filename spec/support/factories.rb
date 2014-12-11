FactoryGirl.define do
  # sequence :token do
  #   SecureRandom.hex(3)
  # end

  sequence(:first_name)     { |n| "first_name #{n}" }
  sequence(:last_name)      { |n| "last_name #{n}" }
  # sequence(:email)          { |n| "test#{n}@example.com" }

  factory :user do
    # device_token { generate(:token) }
    first_name
    last_name
    # email
    # password              "foobar123"
    # password_confirmation "foobar123"
  end

  factory :space do
    width   { rand(0..1000) }
    length  { rand(0..1000) }

    user factory: :user
  end
end
