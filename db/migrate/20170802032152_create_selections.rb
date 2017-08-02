class CreateSelections < ActiveRecord::Migration[5.1]
  def change
    create_table :selections do |t|
      t.integer :product_id, null: false
      t.integer :cart_id, null: false

      t.timestamps
    end
    add_index :selections, :product_id
    add_index :selections, :cart_id
  end
end
