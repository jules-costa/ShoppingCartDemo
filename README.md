# Shopping Cart

This shopping cart demo is built using Rails' ActiveRecord atop a pre-seeded SQLite3 database. You may interact with the database by following the steps outlined here:

1. Run ```bundle install```
2. Run ```bundle exec rake db:schema:load``` and ```bundle exec rake db:seed```
3. Open rails console in your terminal
4. Create and save a new instance of Cart. This cart will be defaulted to active, and you may:

N.B. View the list of products by running ```Product::list```

```
#add_product(title)
#remove_product(title)
#view_cart
#checkout
#view_history
```
Once you checkout, your cart will become inactive, and items will be stored in purchase history. To keep shopping, please create a new Cart instance.


Notes:
- Products are indexed by title and price for speedy lookup
- Selections is a join table to store the many-to-many relationships between carts and products. Both of these foreign keys are indexed
