FactoryGirl.define do

  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar123"
    password_confirmation "foobar123"

    factory :admin do
      admin true
    end

    factory :user_with_question do
      question
    end

    factory :user_with_answer do
      answer
    end

  end

end

