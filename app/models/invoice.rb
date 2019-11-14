class Invoice < ApplicationRecord
  belongs_to :batch

  has_many :invoices_parcels, autosave: true
  has_many :parcels, through: :invoices_parcels

  validates :invoice_operation_number, presence: true,
                                       numericality: true

  validates_format_of :invoice_operation_number, with: /[0-9]{1,9}/

  validates :company_code, presence: true,
                           numericality: true

  validates_format_of :company_code, with: /[0-9]{4}/

  validates :invoice_operation_date, presence: true
  validates :invoices_parcels, length: { minimum: 1, maximum: 10 }

  validates_associated :invoices_parcels
end
