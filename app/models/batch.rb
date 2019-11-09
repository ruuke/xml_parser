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
    message = "Расширение файла долно быть .xml"
    errors.add(:batch, message) unless file.filename.extension == ".xml"
  end

  def file_path
    ActiveStorage::Blob.service.path_for(file.key)
  end
end
