class Record < ApplicationRecord
  validates :user_id, presence: true
  validates :record_title, presence: true, allow_nil: true
  validates :image, presence: true, allow_nil: true
  
  belongs_to :user
  has_many :record_destinations, :dependent => :destroy
  mount_uploader :image, ImageUploader
end
