# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Post.delete_all
Post.create!(
  [
    {
      content: 'Next.js + Ruby on Rails + Docker の環境構築'
    },
    {
      content: 'React Hooks でカスタムフックを作る'
    },
    {
      content: 'GraphQL と Apollo Client 入門'
    },
    {
      content: '【TypeScript4.3】Template Literal Types'
    },
    {
      content: 'Tailwind CSS でダークモード実装'
    },
  ]
)

User.delete_all

User.create!([
  {
    name: "John",
    email: "aaa@gmail.com",
    password_hash: "aaa"
  },
  {
    name: "Tart",
    email: "tae@gmail.com",
    password_hash: "aaa"
  },
  {
    name: "John",
    email: "aaa@gmail.com",
    password_hash: "aaa"
  }
])

require 'faker'
# ユーザーデータの生成
50.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password_hash: Faker::Internet.password,
    createdAt: Faker::Time.between(from: 1.year.ago, to: Time.zone.now),
    updatedAt: Faker::Time.between(from: 1.year.ago, to: Time.zone.now),
    deletedAt: nil
  )
end
