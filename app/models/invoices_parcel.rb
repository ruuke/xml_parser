class InvoicesParcel < ApplicationRecord
  belongs_to :invoice
  belongs_to :parcel

  validates_associated :invoice
end
