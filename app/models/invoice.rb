class Invoice < ApplicationRecord
  belongs_to :batch

  has_many :invoices_parcels, autosave: true
  has_many :parcels, through: :invoices_parcels

  validates :invoices_parcels, length: { minimum: 1, maximum: 10 }

  validates :invoice_operation_number, presence: true,
                                       numericality: true,
                                       length: { maximum: 9 }

  validates :company_code, presence: true,
                           numericality: true,
                           length: { is: 4 }

  validates :invoice_operation_date, presence: true
  validates :company_code, presence: true

  validates_associated :invoices_parcels
end
