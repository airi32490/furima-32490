FactoryBot.define do
  factory :order_address do
    postal_code   { '123-4567' }
    prefecture_id { 10 }
    city          { '横浜市' }
    house_number  { '青山1-1' }
    building_name { '柳ビル' }
    tel_number    { '09012345678' }
  end
end
