# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :edit do
    idiom_id 1
    description "MyText"
    user_id 1
  end
end
