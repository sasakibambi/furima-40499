class Form 
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city_name, :street_address, :building_name, :telephone_number, :user_id, :item_id, :token
  
  # ここにバリデーションの処理を書く
  validates :token, presence: true
  validates :post_code, presence: true,format: { with: /\A\d{3}[-]\d{4}\z/ }
  validates :prefecture_id, presence: true, numericality: { other_than: 0 }
  validates :city_name, presence: true
  validates :street_address, presence: true
  validates :telephone_number, presence: true, format: { with: /\A\d{10,11}\z/ }, 
                              exclusion: { in: %w(-) }
                              







  validates :user_id, presence: true
  validates :item_id, presence: true
  

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

