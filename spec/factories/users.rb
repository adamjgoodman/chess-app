FactoryGirl.define do
  factory :user, class: User do
    sequence :email do |n|
      "dummyEmail#{n}@example.com"
    end
    password 'secretPassword'
    password_confirmation 'secretPassword'
  end
end
