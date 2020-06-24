class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true

  has_one :profile
  accepts_nested_attributes_for :profile
  has_one :address
  has_many :products
  has_many :comments
  has_many :evaluations

  has_many :likes, dependent: :destroy
  has_many :like_products, through: :likes, source: :product
end
