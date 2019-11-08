class Parcel < ApplicationRecord
  has_many :invoices, through: :invoices_parcels

  validates :parcel_code, presence: true

  # добавляем единицу перед ведущими нулями и проверяем кол-во цифр
  def validate_numbers_of_digits
    errors.add("Кол-во чисел в поле должно быть ровно 15") if ('1' << parcel_code).to_i.digits.size != 16
  end
end
