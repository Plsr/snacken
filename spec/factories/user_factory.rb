FactoryBot.define do
  factory :user do
    password { "Test1234" }
    password_confirmation { "Test1234" }
    sequence :email do |n|
      "user#{n}@example.com"
    end
  end
end
