FactoryGirl.define do
  factory :comment do
    sequence(:content) { Faker::Hacker.say_something_smart }
    association :commentable
    user

    trait :with_wrong_attributes do
      content nil
    end
  end

end
