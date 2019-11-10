class Parcel < ApplicationRecord
  has_many :invoices_parcels
  has_many :invoices, through: :invoices_parcels

  validates :parcel_code, presence: true, length: { is: 15 }
  validates :parcel_price, numericality: { greater_than: 0, less_than_or_equal_to: 90000 }
  validate :validate_numbers_of_digits

  private

  # добавляем единицу перед ведущими нулями и проверяем кол-во цифр
  def validate_numbers_of_digits
    message = "Кол-во чисел в поле должно быть ровно 15"
    errors.add(:parcel_code, message) unless ('1' << parcel_code).to_i.digits.size == 16
  end
end
