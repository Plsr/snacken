FactoryBot.define do
  factory :user do
    password { "Test1234" }
    password_confirmation { "Test1234" }
    sequence :email do |n|
      "user#{n}@example.com"
    end
    invite_code { FactoryBot.create(:invite_code).code }

    trait :needs_activation do
      activation_token { 'asd' }
    end
  end
end
