require "faker"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create!(username:  "admin",
#              email: "example@twiterclone.org",
#              password:              "foobar",
#              password_confirmation: "foobar")

99.times do |n|
  username = Faker::Name.name
  email = "example-#{n + 1}@twitterclone.org"
  password = "password"
  User.create!(username: username,
               email: email,
               password:              password,
               password_confirmation: password)
end

# Tweets
users = User.order(:created_at).take(6)
rand(50).times do
  body = Faker::Lorem.sentence(5)
  users.each { |user| user.tweets.create!(body: body, user_id: user.id) }
end
