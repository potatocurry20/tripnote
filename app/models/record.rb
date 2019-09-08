class Record < ApplicationRecord
  validates :user_id, presence: true
  validates :record_title, presence: true
  validates :image, presence: true
  
  belongs_to :user
  mount_uploader :image, ImageUploader
end
