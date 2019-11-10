FactoryBot.define do
  factory :parcel do
    sequence(:parcel_code) { |n| "12345678901234#{n}" }
    parcel_price { 1234 }
  end
end
