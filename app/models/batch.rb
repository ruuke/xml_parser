class Batch < ApplicationRecord
  has_many :invoices, autosave: true

  has_one_attached :file

  validates :id, presence: true,
                 numericality: true

  validates_format_of :id, with: /[0-9]{7}/

  validates :creation_date, presence: true
  validates :guid, presence: true, uniqueness: true

  validates_associated :invoices

  def file_path
    ActiveStorage::Blob.service.path_for(file.key)
  end
end
