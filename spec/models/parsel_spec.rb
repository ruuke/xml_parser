require 'rails_helper'

describe Parcel, type: :model do
  describe 'validations' do
    subject { create :parcel }

    it { should have_many(:invoices).through(:invoices_parcels) }
    it { should have_many :invoices_parcels }
    it { should validate_numericality_of(:price).is_greater_than(0) }
    it { should validate_numericality_of(:price).is_less_than_or_equal_to(90000) }

    it '#validate_numbers_of_digits' do
      expect(subject.valid?).to eq true
    end
  end
end
