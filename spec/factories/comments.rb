FactoryBot.define do
  factory :comment do
    content { "MyString" }
    user_id { 1 }
    item_id { 1 }
  end
end
