# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Favorite.delete_all
Post.delete_all
User.delete_all
ActiveRecord::Base.connection.execute("ALTER TABLE users AUTO_INCREMENT = 1;")
ActiveRecord::Base.connection.execute("ALTER TABLE posts AUTO_INCREMENT = 1;")
User.create!([
  {
    name: "admin",
    email: "admin@admin.com",
    password: 'password',
    password_confirmation: 'password',
    admin: true
  },
  {
    name: "Tart",
    email: "tae@gmail.com",
    password: 'password',
    password_confirmation: 'password',
  },
  {
    name: "John",
    email: "aaa@gmail.com",
    password: 'password',
    password_confirmation: 'password',
  }
])

require 'faker'
# ユーザーデータの生成
50.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
  )
end



100.times do
  post = Post.new(
    content: Faker::Lorem.sentence,
    image_id: Faker::Alphanumeric.alphanumeric(number: 10),
    createdAt: Faker::Time.between(from: 1.year.ago, to: Time.zone.now),
    updatedAt: Faker::Time.between(from: 1.year.ago, to: Time.zone.now),
    deletedAt: Faker::Time.between(from: 1.year.ago, to: Time.zone.now),
    user_id: Faker::Number.between(from: 1, to: 10),
    title: Faker::Lorem.sentence(word_count: 2),
    synopsis: Faker::Lorem.sentence(word_count: 5),
    catchphrase: Faker::Lorem.sentence(word_count: 1),
    number_of_men: Faker::Number.between(from: 1, to: 10),
    number_of_women: Faker::Number.between(from: 1, to: 10),
    total_number_of_people: Faker::Number.between(from: 1, to: 20),
    playtime: Faker::Number.between(from: 0, to: 4)
  )

  # タグを0〜3つの範囲で追加する
  rand(4).times do
    tag_name = Faker::Lorem.word
    tag = Tag.find_by(name: tag_name)
    unless tag
      tag = Tag.new(name: tag_name)
      tag.save
    end
    post.tags << tag
  end

  post.save
end