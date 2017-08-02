class Cart < ApplicationRecord
  has_many :selections

  has_many :products,
    through: :selections,
    source: :product
end
