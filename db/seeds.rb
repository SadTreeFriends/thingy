# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Users
# .create! raises an exception for an invalid user rather than returning false
User.create!(name:  'Example User',
             email: 'example@railstutorial.org',
             password:              'foobar',
             password_confirmation: 'foobar',
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = 'password'
  User.create!(name: name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

# Microposts: Create 50 posts for the first 6 users
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

# Following relationships
users = User.all
first_user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| first_user.follow(followed) }
followers.each { |follower| follower.follow(first_user) }
