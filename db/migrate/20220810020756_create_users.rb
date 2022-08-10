class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :phone
      t.string :address
      t.boolean :admin, default: false
      t.boolean :activated, default: false

      t.timestamps
    end
  end
end
