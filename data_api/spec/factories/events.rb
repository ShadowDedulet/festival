FactoryBot.define do
  factory :event do
    time = DateTime.new(2022, 4, 15, 19)
    sequence(:name) { |n| "event_#{n}" }
    sequence(:date_start) { |n| ( time + n.day ).to_s  }
    sequence(:date_end) { |n| ( time + n.day + 4.hour ).to_s }
    date_start { "2022-04-16 09:51:24" }
    date_end { "2022-04-16 09:51:24" }
  end
end
