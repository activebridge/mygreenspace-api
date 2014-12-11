FactoryGirl.define do
  sequence(:first_name)     { |n| "first_name #{n}" }
  sequence(:last_name)      { |n| "last_name #{n}" }
  sequence(:email)          { |n| "test#{n}@example.com" }
  sequence(:picture)        { "https://robohash.org/my-own-slug.png?size=100x100" }

  factory :user do
    first_name
    last_name
    email
    picture
  end

  factory :space do
    width   { rand(0..1000) }
    length  { rand(0..1000) }

    user factory: :user
  end
end
