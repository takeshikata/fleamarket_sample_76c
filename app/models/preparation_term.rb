class PreparationTerm < ApplicationRecord
  has_many :products

  enum term: {
    １〜２日で発送:0,
    ２〜３日で発送:1,
    ３〜７日で発送:2
  }
end
