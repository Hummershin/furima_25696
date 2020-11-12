FactoryBot.define do
  factory :card do
    card_token { "MyString" }
    customer_token { "MyString" }
    user { nil }
  end
end
