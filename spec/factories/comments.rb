FactoryGirl.define do
  factory :comment do
    sequence(:content) { Faker::Hacker.say_something_smart }
    association :commentable
    user
  end

end
