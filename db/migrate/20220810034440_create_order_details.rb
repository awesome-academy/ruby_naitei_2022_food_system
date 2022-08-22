class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.bigint "order_id", null: false
      t.bigint "product_id", null: false
      t.decimal :price
      t.integer :quality

      t.timestamps
    end
    add_index :order_details, :order_id
    add_index :order_details, :product_id
    add_index :order_details, [:order_id, :product_id], unique: true
  end
end
