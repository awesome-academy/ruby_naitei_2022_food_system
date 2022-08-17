# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |n|
  name = "Cate" << Faker::Food.dish
  Category.create!(name: name,
               parent_id: 0)
end

cates = Category.order(:created_at).take(4)
10.times do
  name = Faker::Food.dish
  desc = Faker::Food.description
  price = rand(1000..3000)
  qty = rand(50..100)
  image 
  cates.each {|cate| cate.products.create!(name: name, description: desc, price: price, stock_quantity: qty)}
end
# Create a main sample user.
User.create!(name: "admin",
             email: "admin@gmail.com",
             password: "12341234",
             password_confirmation: "12341234",
             admin: true)
