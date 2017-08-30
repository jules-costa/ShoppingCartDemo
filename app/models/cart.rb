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
      Selection.create!(product_id: product.id, cart_id: self.id)
      self.reload
      view_cart
    end
  end

  def remove_product(title)
    product = Product.find_by(title: title)
    record = Selection.where(cart_id: self.id, product_id: product.id).first
    Selection.destroy(record.id)
    self.reload
    view_cart
  end

  def view_cart
    items = self.products.to_a
    'Your Cart: ' + items.map { |item| item.title }.join(", ")
  end

  def checkout
    products = self.products.to_a

    out_of_stock = []
    in_stock = []

    products.each do |product|
      if product.available_inventory == 0
        out_of_stock << product
      else
        in_stock << product
        product.available_inventory -= 1
        product.save!
        product.reload
      end
    end

    toggle_active
    generate_receipt(in_stock)
    display_message(out_of_stock)
  end

  def view_history
    purchases = []
    inactive_carts.each do |cart|
      cart.products.to_a.each do |product|
        purchases << product.title
      end
    end
    purchases
  end

  private

  def inactive_carts
    Cart.where(active: false).to_a
  end

  def toggle_active
    self.active = false
    self.save!
  end

  def display_message(array)
    items = array.map { |el| el.title }.join(", ")
    puts "Sorry, we're sold out of #{items}"
  end

  def generate_receipt(array)
    items = array.map { |el| el.title }.join(", ")
    total = array.map { |el| el.price }.reduce(:+)
    puts "Thank you for your order of: #{items}"
    puts "Your total is: $#{total}"
  end

end
