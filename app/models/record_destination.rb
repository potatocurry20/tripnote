class RecordDestination < ApplicationRecord
  validates :user_id, presence: true
  validates :record_id, presence: true
  validates :destination_title, presence: true, allow_nil: true
  validates :image, presence: true, allow_nil: true
  validates :description, presence: true, allow_nil: true
  
  belongs_to :user
  belongs_to :record
  mount_uploader :image, ImageUploader
end
