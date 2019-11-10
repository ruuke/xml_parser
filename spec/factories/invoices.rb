FactoryBot.define do
  factory :invoice do
    association :batch


    invoice_operation_number { 1234567 }
    company_code { 1234 }
    invoice_operation_date { Date.today }
  end
end
