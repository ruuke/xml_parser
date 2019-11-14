FactoryBot.define do
  factory :invoices_parcel do
    association :invoice

    item_qty { 1 }
  end
end
