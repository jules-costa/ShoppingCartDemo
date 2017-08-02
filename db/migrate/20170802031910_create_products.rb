class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.decimal :price, null: false
      t.integer :available_inventory, default: 0

      t.timestamps
    end

    add_index :products, :title
    add_index :products, :price
  end
end
