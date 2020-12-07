class OrderAddress
  include ActiveModel::ActiveModel
  attr_accessor :postal_cade, :prefecture_id, :city, :house_number, :building_name, :tel_number

  with_options precense :true do
  validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/, message: "Input correctly"}
  validates :prefecture_id, numericality: { other_than: 1, message: 'Select' }
  validates :city
  validates :house_number
  validates :tel_number, format: { with: /\A\d{11}\z/, message: "Input only number" }
  end
end