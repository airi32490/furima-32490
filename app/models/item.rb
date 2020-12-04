class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category, :status, :area, :day, :fee

  belongs_to :user
  
  has_one_attached :image
end
