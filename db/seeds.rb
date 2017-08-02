# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.destroy_all
Cart.destroy_all
Selection.destroy_all

product1 = Product.create!(price: 100.00, title: "jumpsuit", available_inventory: 2)
product2 = Product.create!(price: 70.00, title: "slacks", available_inventory: 3)
product3 = Product.create!(price: 30.50, title: "tank top", available_inventory: 4)
product4 = Product.create!(price: 120.50, title: "jeans", available_inventory: 5)
product5 = Product.create!(price: 50.25, title: "blouse", available_inventory: 1)
product6 = Product.create!(price: 70.50, title: "skirt", available_inventory: 3)
product7 = Product.create!(price: 200.00, title: "sneakers", available_inventory: 1)
product8 = Product.create!(price: 100.00, title: "backpack", available_inventory: 7)
product9 = Product.create!(price: 60.00, title: "swimsuit", available_inventory: 2)
product10 = Product.create!(price: 75.75, title: "watch", available_inventory: 3)
product11 = Product.create!(price: 35.00, title: "earrings", available_inventory: 4)
product12 = Product.create!(price: 350.50, title: "dress", available_inventory: 5)

cart1 = Cart.create!(active: false)

selection1 = Selection.create!(product_id: product1.id, cart_id: cart1.id)
selection2 = Selection.create!(product_id: product2.id, cart_id: cart1.id)
selection3 = Selection.create!(product_id: product3.id, cart_id: cart1.id)
