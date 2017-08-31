class ShoppingService
  def initialize(params)

  end

  def validate_new_cart
    # remove inventory from all active carts, except for newest
    # toggle to inactive
  end

  def add_product(product)
    # check inventory
    # raise error if cart is inactive
  end

  def remove_product(product)
  end

  def checkout
    # check inventory of all items in active cart
    # generate receipt and print OOS message
    # decrement inventory
  end
end
