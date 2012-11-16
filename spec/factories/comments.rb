# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    message "MyText"
    user_id 1
    idiom_id 1
  end
end
