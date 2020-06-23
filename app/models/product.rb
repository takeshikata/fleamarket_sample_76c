class Product < ApplicationRecord
  belongs_to :user
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  belongs_to :category
  belongs_to :brand, optional: true
  belongs_to :product_condition
  belongs_to :preparation_term
  belongs_to :shipping_region
  belongs_to :shipping_payer, optional: true
  has_many :comments, dependent: :destroy
  has_many :evaluations, dependent: :destroy

  validates :images, presence: { message: "を入力してください"}
  validates :name,  presence: { message: "を入力してください"}
  validates :introduction,  presence: { message: "を入力してください"}
  validates :price,  presence: { message: "を入力してください"}


  def self.search(keyword)
    return Product.all unless keyword
    Product.where('name LIKE?', "%#{keyword}%")
  end

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end
end
