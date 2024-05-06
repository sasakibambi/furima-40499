class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname,presence: true
  validates :email, presence: true
  validates :password,presence: true, format: { with: /\A[a-zA-Z0-9]+\z/}
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates :password, format: { with: PASSWORD_REGEX}
  validates :family_name, presence: true, format: { with: /\A[一-龥ぁ-ん]+\z/}
  validates :first_name, presence: true, format: { with: /\A[一-龥ぁ-ん]+\z/}
  validates :family_name_kana, presence: true
  validates :first_name_kana , presence: true
  validates :date_of_birth , presence: true
  validates :family_name_kana, presence: true, format: { with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/ }
  validates :first_name_kana, presence: true, format: { with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/ } 
  # validatesはダメな時に弾くもの


  has_many :items
  has_many :purchases

end
