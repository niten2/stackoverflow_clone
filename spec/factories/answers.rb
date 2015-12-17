FactoryGirl.define do

  factory :answer do
    sequence(:content) { Faker::Hacker.say_something_smart }
    question
    user
  end

  factory :invalid_answer, class: 'Answer' do
    content nil
    question
    user
  end

end
