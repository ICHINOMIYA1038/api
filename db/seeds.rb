# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Message.delete_all
ChatRoom.delete_all
Favorite.delete_all
Access.delete_all
Post.delete_all
User.delete_all

#MYSQL用
#ActiveRecord::Base.connection.execute("ALTER TABLE users AUTO_INCREMENT = 1;")
#ActiveRecord::Base.connection.execute("ALTER TABLE posts AUTO_INCREMENT = 1;")

# POSTGRES用
#ActiveRecord::Base.connection.execute("ALTER SEQUENCE posts_post_id_seq RESTART WITH 1;")
#ActiveRecord::Base.connection.execute("ALTER SEQUENCE users_user_id_seq RESTART WITH 1;")

normal_users = []


sampleusers = User.create!([
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

tag = Tag.new(name: 'sampleProduction')
tag.save

10.times do
  NewsItem.create(
    date: Time.zone.now.strftime('%Y/%m/%d'),
    category: '新着脚本',
    title: "#{Faker::Name.name}が#{Faker::Lorem.sentence(word_count: 1)}を投稿しました"
  )
end
require 'faker'
# ユーザーデータの生成
50.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
  )
  normal_users << user
  user.save
end

chat_room1 = ChatRoom.create(name: 'Chat Room 1')
chat_room2 = ChatRoom.create(name: 'Chat Room 2')
Message.create(content: 'Hello from1 User 1', sent_at: Time.now, chat_room_id: chat_room1.id, user_id: sampleusers[0].user_id)
Message.create(content: 'Hi there!', sent_at: Time.now, chat_room_id: chat_room1.id, user_id: sampleusers[0].user_id)
Message.create(content: 'Greetings', sent_at: Time.now, chat_room_id: chat_room1.id, user_id: sampleusers[0].user_id)
Message.create(content: 'Chatting in Chat Room 2', sent_at: Time.now, chat_room_id: chat_room2.id, user_id: sampleusers[0].user_id)
Message.create(content: 'Having a good time!', sent_at: Time.now, chat_room_id: chat_room2.id, user_id: sampleusers[0].user_id)


100.times do
  post = Post.new(
    content: Faker::Lorem.sentence,
    image_id: Faker::Alphanumeric.alphanumeric(number: 10),
    createdAt: Faker::Time.between(from: 1.year.ago, to: Time.zone.now),
    updatedAt: Faker::Time.between(from: 1.year.ago, to: Time.zone.now),
    deletedAt: Faker::Time.between(from: 1.year.ago, to: Time.zone.now),
    user_id:  normal_users.sample.user_id,
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