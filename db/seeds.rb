# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
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

Post.create!(
  [
    {
      content: 'Next.js + Ruby on Rails + Docker の環境構築',
      user_id: 1
    },
    {
      content: 'React Hooks でカスタムフックを作る',
      user_id: 1
    },
    {
      content: 'GraphQL と Apollo Client 入門',
      user_id: 2
    },
    {
      content: '【TypeScript4.3】Template Literal Types',
      user_id: 3
    },
    {
      content: 'Tailwind CSS でダークモード実装',
      user_id: 4
    },
  ]
)


