class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts do |t|
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
