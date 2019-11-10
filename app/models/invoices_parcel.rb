class InvoicesParcel < ApplicationRecord
  belongs_to :invoice
  belongs_to :parcel

  validates :item_qty, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 50 }
  validates :parcel_price, numericality: { greater_than: 0, less_than_or_equal_to: 90000 }
  validate :validate_numbers_of_digits

  private

  # добавляем единицу перед ведущими нулями и проверяем кол-во цифр
  def validate_numbers_of_digits
    message = "Кол-во чисел в поле должно быть ровно 15"
    errors.add(:parcel_id, message) unless ('1' << parcel_id).to_i.digits.size == 16
  end
end
