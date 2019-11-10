require 'rails_helper'

describe Parcel, type: :model do
  describe 'validations' do
    subject { create :parcel }

    it { should have_many(:invoices).through(:invoices_parcels) }
    it { should have_many :invoices_parcels }

    xit { should validate_presence_of :parcel_code }
    it { should validate_length_of(:parcel_code).is_equal_to(15) }
    xit { should validate_numericality_of(:parcel_price).is_greater_than(0) }
    xit { should validate_numericality_of(:parcel_price).is_less_than_or_equal_to(90000) }

    xit '#validate_numbers_of_digits' do
      expect(subject.valid?).to eq true
    end
  end
end
