class Product < ApplicationRecord
  validates :title, :price, presence: true

  has_many :selections

  has_many :carts,
    through: :selections,
    source: :cart

  def self.list
    list = []
    Product.all.each do |product|
      list << product.title
    end
    list
  end
end
