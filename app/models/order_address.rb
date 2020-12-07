class OrderAddress
  include ActiveModel::ActiveModel
  attr_accessor :postal_cade, :prefecture_id, :city, :house_number, :building_name, :tel_number
end