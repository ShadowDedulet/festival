# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Action.delete_all

actions = [
  { action_type: 1, status: 1, fio: 'fio_1', ticket_id: 1 },
  { action_type: 1, status: 1, fio: 'fio_2', ticket_id: 2 },
  { action_type: 0, status: 1, fio: 'fio_1', ticket_id: 1 },
  { action_type: 0, status: 0, fio: 'fio_1', ticket_id: 1 },
  { action_type: 1, status: 1, fio: 'fio_3', ticket_id: 3 },
  { action_type: 1, status: 0, fio: 'fio_3', ticket_id: 3 },
  { action_type: 0, status: 1, fio: 'fio_2', ticket_id: 2 },
  { action_type: 1, status: 1, fio: 'fio_2', ticket_id: 2 }
]

actions.each do |a|
  Action.create(
    action_type: a[:action_type],
    status: a[:status],
    fio: a[:fio],
    ticket_id: a[:ticket_id]
  )
  sleep(rand)
end
