class Product < ApplicationRecord
  belongs_to :user
  has_many :images
  belongs_to :category
  belongs_to :brand
  belongs_to :product_condition
  belongs_to :preparation_term
  belongs_to :shipping_region
  belongs_to :shipping_payer
end
