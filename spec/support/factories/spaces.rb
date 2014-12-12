FactoryGirl.define do
  factory :space do
    width   { rand(0..1000) }
    length  { rand(0..1000) }

    user factory: :user
  end
end
