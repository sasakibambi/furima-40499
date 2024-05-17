class Form
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city_name, :street_address, :building_name, :telephone_number, :user_id, :item_id,
                :token

  # ここにバリデーションの処理を書く
  with_options presence: true do
  validates :token
  validates :post_code,  format: { with: /\A\d{3}-\d{4}\z/ }
  validates :prefecture_id,  numericality: { other_than: 0 }
  validates :city_name 
  validates :street_address 
  validates :telephone_number,  format: { with: /\A\d{10,11}\z/ },
                               exclusion: { in: %w[-] }

  validates :user_id
  validates :item_id 
  end

  def save
    # 購入情報を保存
    # purchase = Purchase.create(user_id:, item_id:)
    # purchase = Purchase.create(user_id:, item_id:, token:)
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
