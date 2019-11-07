class Invoice < ApplicationRecord
  validates :invoice_operation_number, presence: true,
                                       numericality: true,
                                       length: { maximum: 9 }

  validates :company_code, presence: true,
                           numericality: true,
                           length: { is: 4 }

  validates :invoice_operation_date, presence: true
  validates :icompany_code, presence: true
end
