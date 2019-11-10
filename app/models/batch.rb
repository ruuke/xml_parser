class Batch < ApplicationRecord
  has_many :invoices, autosave: true

  has_one_attached :file

  validates :batch_id, presence: true,
                       numericality: true

  validates_format_of :batch_id, with: /[0-9]{7}/

  validates :creation_date, presence: true
  validates :guid, presence: true, uniqueness: true
  # validate :file_extension

  validates_associated :invoices

  def file_path
    ActiveStorage::Blob.service.path_for(file.key)
  end

  private

  # def file_extension
  #   message = "Расширение файла долно быть .xml"
  #   errors.add(:file, message) unless file.filename.extension == "xml"
  # end
end
