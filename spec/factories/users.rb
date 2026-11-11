FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    name { "Test User" }
    provider { "keycloak" }
    sequence(:uid) { |n| "kc-uid-#{n}" }
    role { :user }

    trait :admin do
      role { :admin }
    end
  end
end
