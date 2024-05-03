class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :email , presence: true
  validates :encrypted_password, presence: true
  validates :family_name, presence: true
  validates :first_name, presence: true
  validates :family_name_kana, presence: true
  validates :first_name_kana , presence: true
  validates :date_of_birth , presence: true
  # validatesはダメな時に弾くもの


  has_many :items
  has_many :purchases

end
