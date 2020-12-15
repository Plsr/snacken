FactoryBot.define do
  factory :invite_code do
    code { SecureRandom.alphanumeric(15) }

    trait :used do
      used_at { Time.now }
    end
  end
end
