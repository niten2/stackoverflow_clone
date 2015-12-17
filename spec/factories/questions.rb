FactoryGirl.define do

  factory :question do
    sequence(:title)   { Faker::Name.name }
    sequence(:content) { Faker::Hacker.say_something_smart }
    user
  end

  factory :invalid_question, class: "Question" do
    title   nil
    content nil
    user
  end

end
