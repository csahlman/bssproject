# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :report do
    reportable_type "MyString"
    reportable_id 1
    user_id 1
    message "MyText"
  end
end
