class ShippingAddress < ApplicationRecord
  belongs_to :purchase

  validates :post_code, presence: true
  validates :prefecture_id, presence: true
  validates :city_name, presence: true
  validates :street_address, presence: true
  validates :building_name, presence: true
  validates :telephone_number, presence: true
end