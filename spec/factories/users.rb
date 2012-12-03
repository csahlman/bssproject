# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do |f|
    f.sequence(:name)  { |n| "Charlie Sahlman_#{n}" }
    f.sequence(:email)  { |n| "csahlman_#{n}@gmail.com" }
    zip_code "02493"
    password "foobar"
    password_confirmation "foobar"
    about_me "I am doing work"
    admin false
  end

  # factory :admin, class: User do 
  #   f.sequence(:name)  { |n| "Charlie Sahlman_#{n}_admin" }
  #   f.sequence(:email)  { |n| "csahlman_#{n}@gmail.com" }
  #   zip_code "02493"
  #   password "foobar"
  #   password_confirmation "foobar"
  #   about_me "I am an admin"
  #   admin true   
  # end
end
