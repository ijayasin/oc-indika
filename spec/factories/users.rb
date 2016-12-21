FactoryGirl.define do
  factory :user do
    sequence(:name){|n| "Test#{n} User#{n}"}
    sequence(:email){|n| "test#{n}@example.com" }
    password "abc123"

    trait :admin do
      role 'admin'
    end
  end
end
