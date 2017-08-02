class Cart < ApplicationRecord
  has_many :selections

  has_many :products,
    through: :selections,
    source: :product

  def self.checkout
    in_stock = []
    sold_out = []
    items = active_cart.products
    items.each do |item|
      if item.available_inventory > 0
        in_stock << item
        item.available_inventory -= 1
      else
        sold_out << item
      end
    end
    active_cart.active = false
    active_cart.save!
    display_message(sold_out)
    generate_receipt(in_stock)
  end

  def self.view_history
    history = Cart.where(active: false).to_a
  end

  def add_product(title)
    product = Product.where(title: title).to_a
    Selection.create!(product_id: product.id, cart_id: active_cart.id)
  end

  def remove_product(title)
    item = Product.where(title: title).to_a
    record = Selection.where(cart_id: Cart.active_cart.id, product_id: item.id).limit(1).to_a
    Selection.destroy(record.id)
  end

  def view_cart
    active_cart.products
  end

  private

  def self.inactive_carts
    Cart.where(active: false).to_a
  end

  def self.active_cart
    Cart.where(active: true).to_a
  end

  def display_message(array)
    x = array.map { |el| el.title }.join(", ")
    puts "We're sorry, but we're sold out of #{x}."
  end

  def generate_receipt(array)
    x = array.map { |el| el.title }
    puts "Thank you for your order of: #{x}"
  end

end
