class Product < ApplicationRecord
  validates :title, :price, presence: true
  
  has_many :selections

  has_many :carts,
    through: :selections,
    source: :cart
end
