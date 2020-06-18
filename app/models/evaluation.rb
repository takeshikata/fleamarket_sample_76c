class Evaluation < ApplicationRecord
  enum evaluation: { good: 1,
                     normal: 2,
                     bad: 3 }

  belongs_to :user
  belongs_to :product
end
