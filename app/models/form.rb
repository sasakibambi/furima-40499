class Form < ApplicationRecord
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city_name, :street_address, :building_name, :telephone_number

  # ここにバリデーションの処理を書く
  validates :post_code, presence: true
  validates :prefecture_id, presence: true
  validates :city_name, presence: true
  validates :street_address, presence: true
  validates :building_name, presence: true
  validates :telephone_number, presence: true

  def save
    # 購入情報を保存
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    
    # 配送先情報を保存
    ShippingAddress.create(
      purchase_id: purchase.id,
      post_code: post_code,
      prefecture_id: prefecture_id,
      city_name: city_name,
      street_address: street_address,
      building_name: building_name,
      telephone_number: telephone_number
    )
  end
end

  class Purchase < ApplicationRecord
    belongs_to :user
    belongs_to :item
    has_one :shipping_address
  end

  class ShippingAddress < ApplicationRecord
    belongs_to :purchase
  end