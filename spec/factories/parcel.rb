FactoryBot.define do
  factory :parcel do
    sequence(:code) { |n| "12345678901234#{n}" }
    price { 1234 }
  end
end
