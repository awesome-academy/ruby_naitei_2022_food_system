# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

#create categories
5.times do |n|
  name = "Cate" << Faker::Food.dish
  Category.create!(name: name,
               parent_id: 0)
end

#create categries include their products
Category.all.each do |cate|
  15.times do
    name = Faker::Food.dish
    desc = Faker::Food.description
    price = rand(1000..3000)
    qty = rand(50..100)
    prod = cate.products.new(
    name: name, description: desc, price: price, stock_quantity: qty)
    prod.save!
    prod.images.attach(io: File.open("#{Rails.root}/app/assets/images/images/photo#{rand(0..2)}.jpg"),
                                      filename: "photo#{rand(0..2)}.jpg",
                                      content_type: "image/jpg")
  end
end

# Create a main sample user.
User.create!(name: "admin",
             email: "admin@gmail.com",
             password: "12341234",
             password_confirmation: "12341234",
             address: "Ho chi minh, viet nam",
             phone: "0123456782",
             admin: true)
#crate user
10.times do |n|
  name = Faker::Name.name;
  email = Faker::Internet.email(name: name)
  password = "12345678"
  address = Faker::Address.full_address
  phone = rand.to_s[2..11]
  User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password,
              address: address,
              phone: phone,
              admin: false)
end

# create orders
users = User.where("id != ?",1).take(4)
users.each do |user|
  #each user order 5 times
  5.times do |n|
    order = user.orders.create!(
      user_email: user.email,
      user_address: user.address,
      user_phone: user.phone,
      note: Faker::Lorem.sentence(word_count: rand(2..8)),
      status: rand(0..4)
    )
    #each order have 1-4 products
    rand(1..4).times do |n|
      product = Product.where(id:n+2).pluck :id, :price
      qty = rand(1..3)
      order.order_details.create!(
        product_id: product[0][0],
        price: product[0][1],
        quantity: qty
      )
    end
  end
end
