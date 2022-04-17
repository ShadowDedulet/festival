# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Action.delete_all

10.times do |_i|
  rnd_id = rand(1..5)
  Action.create(
    action: rand(2),
    status: rand(2),
    fio: "fio_#{rnd_id}",
    ticket_id: rnd_id * 10
  )
end
