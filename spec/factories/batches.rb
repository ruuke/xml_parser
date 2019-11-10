FactoryBot.define do
  factory :batch do
    sequence(:batch_id) { |n| "123456#{n}".to_i }
    sequence(:guid) { |n| "123123ewfwefwef435345#{n}" }
    creation_date { Date.today }
    file { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'sales_data.xml'), 'application/xml') }

    trait :invalid do
      batch_id { nil }
      file { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'sales_data1.xml'), 'application/xml') }
    end
  end
end
