FactoryBot.define do
  factory :shopping_list_ingredient do
    shopping_list { nil }
    ingredient { nil }
    unit { "MyString" }
    amount { 1 }
    checked_off_at { "2020-09-12 12:52:39" }
  end
end
