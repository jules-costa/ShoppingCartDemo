class Cart < ApplicationRecord
  has_many :selections

  has_many :products,
    through: :selections,
    source: :product

  def add_product(title)
    product = Product.find_by(title: title)
    if product.available_inventory == 0
      puts "Sorry, we're out of stock"
    else
      Selection.create!(product_id: product.id, cart_id: Cart.active_cart.id)
      self.view_cart
    end
  end

  def remove_product(title)
    product = Product.where(title: title).first
    record = Selection.where(cart_id: Cart.active_cart.id, product_id: product.id).limit(1).first
    Selection.destroy(record.id)
    self.view_cart
  end

  def view_cart
    products = Cart.active_cart.products.to_a
    'Your Cart: ' + products.map { |product| product.title }.join(", ")
  end

  def checkout
    in_stock = []
    sold_out = []
    cart = Cart.active_cart
    products = cart.products.to_a

    products.each do |product|
      if product.available_inventory > 0
        in_stock << product
        product.available_inventory -= 1
        product.save!
      else
        sold_out << product
      end
    end

    self.toggle_active(cart)
    self.generate_receipt(in_stock)
    self.display_message(sold_out) if sold_out.length > 0
  end

  def view_history
    purchases = []
    Cart.inactive_carts.each do |cart|
      cart.products.to_a.each do |product|
        purchases << product.title
      end
    end
    purchases
  end

  protected

  def self.inactive_carts
    Cart.where(active: false).includes(:products).to_a
  end

  def self.active_cart
    Cart.where(active: true).includes(:products).first
  end

  def toggle_active(cart)
    cart.active = false
    cart.save!
  end

  def display_message(array)
    x = array.map { |el| el.title }.join(", ")
    puts "We're sorry, but we're sold out of: #{x}"
  end

  def generate_receipt(array)
    x = array.map { |el| el.title }.join(", ")
    total = array.map { |el| el.price }.reduce(:+)
    puts "Thank you for your order of: #{x}"
    puts "Your total is: $#{total}"
  end

end
