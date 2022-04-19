FactoryBot.define do
  factory :ticket do
    type { 1 }
    status { 1 }
    start_price { 1 }
    event { nil }
    user { nil }
  end
end
