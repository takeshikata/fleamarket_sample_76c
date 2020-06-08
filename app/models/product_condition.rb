class ProductCondition < ApplicationRecord
  has_many :products

  enum condition: {
    新品、未使用:0,
    未使用に近い:1,
    目立った傷や汚れなし:2,
    やや傷や汚れあり:3,
    傷や汚れあり:4,
    全体的に全体的に状態が悪い:5
  }
end
