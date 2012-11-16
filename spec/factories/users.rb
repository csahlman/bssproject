# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do |f|
    f.sequence(:name)  { |n| "Charlie Sahlman_#{n}" }
    f.sequence(:email)  { |n| "csahlman_#{n}@gmail.com" }
    password "foobar"
    password_confirmation "foobar"
    about_me "I am doing work"
  end
end
