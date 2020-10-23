FactoryBot.define do
  factory :item do
    name { 'サンプル商品' }
    info { 'サンプル商品の説明' }
    price { 1000 }
    category_id { 1 }
    sales_status_id { 1 }
    shipping_fee_status_id { 1 }
    prefecture_id { 1 }
    scheduled_delivery_id { 1 }
    association :user
    
    after(:build) do |item|
      item.image.attach(io: File.open('spec/fixtures/sample.png'), filename: 'sample.png')
    end

    trait :sold_out do
      after(:create) do |item|
        create(:item_transaction, item: item, user: create(:user))
      end
    end
  end
end
  