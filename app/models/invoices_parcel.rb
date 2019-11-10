class InvoicesParcel < ApplicationRecord
  belongs_to :invoice
  belongs_to :parcel

  validates :item_qty, presence: true,
            numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 50 }
  validates :parcel_price, presence: true,
            numericality: { greater_than: 0, less_than_or_equal_to: 90000 }
  validates :parcel_id, presence: true
end
