# This will guess the User class
FactoryGirl.define do
  factory :user do
    email 'alex@alex.com'
    password '12345678'
    password_confirmation '12345678'
  end

  # This will use the User class (Admin would have been guessed)
  factory :admin do
    email 'a@alex.com'
    password '12345678'
    password_confirmation '12345678'
  end
end