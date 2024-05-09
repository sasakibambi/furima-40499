FactoryBot.define do
  factory :item do
    product_name { "Sample Product" }
    product_description { "This is a sample description." }
    category_id { 1 }
    product_condition_id { 1 }
    shipping_fee_burden_id { 1 }
    prefecture_id { 1 }
    shipping_day_id { 1 }
    selling_price { 1000 }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/sample_image.jpg'), filename: 'sample_image.jpg', content_type: 'jpg')
    end

    association :user
  end
end