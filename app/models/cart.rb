class Cart < ApplicationRecord
  has_many :selections

  has_many :products,
    through: :selections,
    source: :product

  def self.checkout
    in_stock = []
    sold_out = []
    cart = Cart.active_cart
    products = cart.products.to_a
    products.each do |product|
      if product.available_inventory > 0
        in_stock << product
        product.available_inventory -= 1
      else
        sold_out << product
      end
    end
    cart.active = false
    cart.save!
    Cart.generate_receipt(in_stock)
    Cart.display_message(sold_out) if sold_out.length > 0
  end

  def self.view_history
    purchases = []
    old_carts = Cart.where(active: false).includes(:products).to_a
    debugger
    old_carts.each do |cart|
      cart.products.each do |product|
        purchases << product
      end
    end
    purchases
  end

  def add_product(title)
    product = Product.where(title: title).first
    Selection.create!(product_id: product.id, cart_id: Cart.active_cart.id)
  end

  def remove_product(title)
    product = Product.where(title: title).first
    record = Selection.where(cart_id: Cart.active_cart.id, product_id: product.id).limit(1).first
    Selection.destroy(record.id)
  end

  def view_cart
    products = Cart.active_cart.products.to_a
    products.map { |product| product.title }
  end

  private

  def self.inactive_carts
    Cart.where(active: false).to_a
  end

  def self.active_cart
    Cart.where(active: true).first
  end

  def self.display_message(array)
    x = array.map { |el| el.title }.join(", ")
    puts "We're sorry, but we're sold out of #{x}"
  end

  def self.generate_receipt(array)
    x = array.map { |el| el.title }.join(", ")
    puts "Thank you for your order of: #{x}"
  end

end
