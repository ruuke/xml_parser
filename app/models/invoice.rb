class Invoice < ApplicationRecord
  belongs_to :batch

  has_many :invoices_parcels
  has_many :parcels, through: :invoices_parcels

  validates_length_of :invoices_parcels, in: 1..10

  validates :invoice_operation_number, presence: true,
                                       numericality: true,
                                       length: { maximum: 9 }

  validates :company_code, presence: true,
                           numericality: true,
                           length: { is: 4 }

  validates :invoice_operation_date, presence: true
  validates :icompany_code, presence: true
end
