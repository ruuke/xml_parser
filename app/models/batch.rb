class Batch < ApplicationRecord
  validates :batch_id, presence: true,
                       numericality: true,
                       length: { is: 7 }

  validates :creation_date, presence: true
  validates :guid, presence: true
end
