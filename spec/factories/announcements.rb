# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :announcement do
    message "MyText"
    starts_at "2012-11-23 08:24:49"
    ends_at "2012-11-23 08:24:49"
  end
end
