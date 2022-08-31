class AddIndexToRatings < ActiveRecord::Migration[6.1]
  def change
  end
  add_index :ratings, [:user_id, :product_id], unique: true
end
