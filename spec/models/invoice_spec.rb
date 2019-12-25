require 'rails_helper'

describe Invoice, type: :model do
  subject {build :invoice }

  it { should belong_to(:batch) }
  it { should have_many(:invoices_parcels) }
  it { should have_many(:parcels).through(:invoices_parcels) }

  it { should validate_presence_of :operation_number }
  it { should validate_uniqueness_of :operation_number }
  it { should validate_numericality_of :operation_number }
  it { should allow_value(123456789).for(:operation_number) }

  it { should validate_presence_of :company_code }
  it { should validate_numericality_of :company_code }
  it { should allow_value(1234).for(:company_code) }

  it { should validate_presence_of :operation_date }

  it "should validate associate invoices_parcels" do
    subject.invoices_parcels.build(parcel_id: 1)
    subject.save.should eq(false)
  end
end
