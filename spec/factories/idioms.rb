# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :idiom do
    title "Ruby on Rails"
    description "A sweet programming language and framework"
    description_right "Another sweet frame"
    summary "Hey this is my summary"
    user
  end
end
