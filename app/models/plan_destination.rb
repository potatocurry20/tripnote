class PlanDestination < ApplicationRecord
  validates :user_id, presence: true
  validates :plan_id, presence: true
  validates :destination_title, presence: true
  validates :image, presence: true
  validates :description, presence: true
  
  belongs_to :user
  belongs_to :plan
  mount_uploader :image, ImageUploader
end
