# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vote do
    vote_direction "MyString"
    voteable_id 1
    voteable_type "MyString"
    user_id 1
  end
end
