require 'rails_helper'

describe InvoicesParcel, type: :model do
  describe 'validations' do
    subject { build :invoices_parcel }

    it { should belong_to(:invoice) }
    it { should belong_to(:parcel) }

    it { should validate_presence_of :parcel_id }
    it { should validate_presence_of :item_qty }
    it { should validate_numericality_of(:item_qty).is_greater_than_or_equal_to(1) }
    it { should validate_numericality_of(:item_qty).is_less_than_or_equal_to(50) }
  end
end
