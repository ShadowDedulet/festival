# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

3.times do |i|
  Event.create(
    name: "event_#{i}",
    date_start: (i * 2).days.from_now,
    date_end: (i * 2 + 1).days.from_now
  )
end

events = Event.all

events.each do |e|
  200.times do |i|
    is_category_0 = i < 150
    Ticket.create(
      ticket_type: is_category_0 ? 0 : 2,
      status: 0,
      start_price: is_category_0 ? 1000 : 2000,
      event_id: e.id
    )
  end
end
