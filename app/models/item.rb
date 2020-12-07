class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :area
  belongs_to_active_hash :day
  belongs_to_active_hash :fee

  belongs_to :user
  has_one :order

  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :name
    validates :describe
    validates :price, numericality: { only_integer: true, message: 'is invalid. Input half-width characters.' }
  end

  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'is out of setting range' }

  with_options numericality: { other_than: 1, message: 'Select' } do
    validates :category_id
    validates :status_id
    validates :fee_id
    validates :area_id
    validates :day_id
  end
end
