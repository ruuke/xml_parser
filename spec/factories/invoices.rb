FactoryBot.define do
  factory :invoice do
    association :batch


    operation_number { 1234567 }
    company_code { 1234 }
    operation_date { Date.today }
  end
end
