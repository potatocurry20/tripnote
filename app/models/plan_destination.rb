class PlanDestination < ApplicationRecord
  validates :user_id, presence: true
  validates :plan_id, presence: true
  validates :destination_title, presence: true, allow_nil: true
  validates :description, presence: true, allow_nil: true
  
  belongs_to :user
  belongs_to :plan
  mount_uploader :image, ImageUploader
end
