# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([
  { fio: 'John Doe', age: rand(10..35), document_type: rand(0..2), document_number: rand(100000..1000000), role: 1, login: 'john', password: '12345678' },
  { fio: 'Jane Doe', age: rand(10..35), document_type: rand(0..2), document_number: rand(100000..1000000), login: 'jane', password: '12345678' },
  { fio: 'Ahley Cooper', age: rand(10..35), document_type: rand(0..2), document_number: rand(100000..1000000), login: 'ashley', password: '12345678' },
  { fio: 'Elena Ostin', age: rand(10..35), document_type: rand(0..2), document_number: rand(100000..1000000), login: 'elena', password: '12345678' },
  { fio: 'Bonnie Bright', age: rand(10..35), document_type: rand(0..2), document_number: rand(100000..1000000), login: 'bonnie', password: '12345678' },
  { fio: 'Jack Frost', age: rand(10..35), document_type: rand(0..2), document_number: rand(100000..1000000), login: 'jack', password: '12345678' },
  { fio: 'Tom Holland', age: rand(10..35), document_type: rand(0..2), document_number: rand(100000..1000000), login: 'tom', password: '12345678' },
  { fio: 'Kellie Jackson', age: rand(10..35), document_type: rand(0..2), document_number: rand(100000..1000000), login: 'kellie', password: '12345678' },
  { fio: 'Jessica Olson', age: rand(10..35), document_type: rand(0..2), document_number: rand(100000..1000000), login: 'jessica', password: '12345678' },
  { fio: 'William Porter', age: rand(10..35), document_type: rand(0..2), document_number: rand(100000..1000000), login: 'william', password: '12345678' }
])
