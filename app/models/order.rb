class Order < ApplicationRecord
  belongs_to :user
  belomgs_to :item
  has_one :adrdess
end
