FactoryBot.define do
  factory :purchase do
    post_code { '123-4567' }
    prefecture_id { 1 }
    city_name { '横浜市緑区' }
    street_address { '青山1-1-1' }
    building_name { '柳ビル103' }
    telephone_number { '09012345678' }
  end
end
