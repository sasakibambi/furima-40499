class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_one_attached :image
  belongs_to :user
  belongs_to :category 
  belongs_to :prefecture
  belongs_to :product_condition
  belongs_to :shipping_day
  belongs_to :shipping_fee_burden

  # ↑紐づいたユーザーが存在しているかのチェックをしている
  # →validates :user, presence: trueは必要ない

  
  validates :product_name, presence: true
  validates :product_description, presence: true
  validates :category_id, presence: true
  validates :product_condition_id, presence: true
  validates :shipping_fee_burden_id, presence: true
  validates :prefecture_id, presence: true
  validates :shipping_day_id, presence: true
  validates :selling_price, presence: true
  validates :selling_price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  validate :valid_selling_price_format

  validates :image, presence: true
  

  validates :category_id, numericality: { other_than: 0 , message: "can't be blank"} 
  validates :product_condition_id, numericality: { other_than: 0 , message: "can't be blank"} 
  validates :shipping_fee_burden_id, numericality: { other_than: 0 , message: "can't be blank"} 
  validates :prefecture_id, numericality: { other_than: 0 , message: "can't be blank"} 
  validates :shipping_day_id, numericality: { other_than: 0 , message: "can't be blank"} 

  validate :image_attached

  private

  def valid_selling_price_format
    unless selling_price.to_s.match?(/\A[0-9]+\z/)
      errors.add(:selling_price, "must be a valid numerical format")
    end
  end

  def image_attached
    unless image.attached?
      errors.add(:image, "must be attached")
    end
  end

end
