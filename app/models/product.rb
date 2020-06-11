class Product < ApplicationRecord
  belongs_to :user
  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true
  has_one :category
  belongs_to :brand, optional: true
  belongs_to :product_condition
  belongs_to :preparation_term
  belongs_to :shipping_region
  belongs_to :shipping_payer, optional: true

  def self.search(keyword)
    return Product.all unless keyword
    Product.where('name LIKE?', "%#{keyword}%")
  end
end
