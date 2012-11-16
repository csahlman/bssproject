# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Charlie Sahlman"
    email "csahlman@gmail.com"
    password "foobar"
    password_confirmation "foobar"
    about_me "I am doing work"
  end
end
