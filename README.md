# Shopping Cart

This shopping cart demo is built using Rails' ActiveRecord atop a pre-seeded SQLite3 database. You may interact with the database by following the steps outlined here:

1. Run bundle install
2. Run ```./setup_db.sh``` to create and seed the database
3. Open rails console in your terminal
4. Create and save a new instance of Cart. This cart will be defaulted to active, and you may:

N.B. View the list of products by running ```Product::list```

```
#add_product(title)
#remove_product(title)
#view_cart
#checkout
```

Once you checkout, your cart will become inactive. To keep shopping, please create a new Cart instance.

To view past purchases (an inactive cart is seeded for you) you may call the class method:
```
#view_history
```

Notes:
- Products are indexed by title and price for speedy lookup
- Selections is a join table to store the many-to-many relationships between carts and products. Both of these foreign keys are indexed
