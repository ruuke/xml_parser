class Batch < ApplicationRecord
  has_many :invoices

  has_one_attached :file

  validates :batch_id, presence: true,
                       numericality: true,
                       length: { is: 7 }

  validates :creation_date, presence: true
  validates :guid, presence: true
  validate :file_extension

  def file_extension
    errors.add("Расширение файла долно быть .xml") if file.filename.extention == ".xml"
  end
end
