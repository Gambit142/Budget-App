# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

bernard = User.create!(name: 'Bernard', email: 'bernard@gmail.com', password: '123456' )

sports = bernard.categories.create!(name: 'Entertainment', icon: 'football')
record = bernard.records.create!(name: 'FifaPro', amount: 50.25)

CategoryRecord.create!(category: sports, record: record)