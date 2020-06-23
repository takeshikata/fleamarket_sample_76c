class Evaluation < ApplicationRecord
  belongs_to :user
  belongs_to :product

  # 同じ商品に対して一意性
  validates :product_id, uniqueness: true
end
