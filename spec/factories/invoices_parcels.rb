FactoryBot.define do
  factory :invoices_parcel do
    association :invoice
    association :parcel

    item_qty { 1 }
    parcel_price { 1234 }
  end
end
