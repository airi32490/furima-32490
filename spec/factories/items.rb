FactoryBot.define do
  factory :item do
    name        { 'テスト' }
    price       { 5000 }
    describe    { 'これはテストです' }
    category_id { 5 }
    status_id   { 2 }
    area_id     { 10 }
    day_id      { 2 }
    fee_id      { 3 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test.jpg'), filename: 'test.jpg')
    end
  end
end
