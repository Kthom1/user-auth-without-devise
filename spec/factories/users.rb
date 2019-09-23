FactoryGirl.define do 
  factory :user do
    sequence(:name) { |n| "test#{n}" }
    sequence(:email) { |n| "test#{n}@test.com" }
    password '12345678'
    password_confirmation '12345678'
    reset_password_token nil
    reset_password_sent_at nil
  end
end