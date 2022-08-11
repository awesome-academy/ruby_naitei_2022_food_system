# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |n|
  name = "Món " << Faker::Food.dish
  Category.create!(name: name,
               parent_id: 0)
end
require "faker"
# Create a main sample user.
User.create!(name: "admin",
             email: "admin@gmail.com",
             password: "12341234",
             password_confirmation: "12341234",
             admin: true)
