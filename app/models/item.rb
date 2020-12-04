class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category, :status, :area, :day, :fee

  belongs_to :user
  
  has_one_attached :image

  with_options numericality: {other_than: 1} do
    validates :category
    validates :status
    validates :area
    validates :day
    validates :fee
  end

  with_options precense: true do
    validates :name
    validates :price, numericality: { only_integer: true, message: "is invalid. Input half-width characters." }
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "is out of setting range"}
    validates :describe
  end
end
