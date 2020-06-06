class Product < ApplicationRecord
  belongs_to :user, optional: true
  has_many :images
  belongs_to :category, optional: true
  belongs_to :brand, optional: true
  belongs_to :product_condition, optional: true
  belongs_to :preparation_term, optional: true
  belongs_to :shipping_region, optional: true
  belongs_to :shipping_payer, optional: true
end
