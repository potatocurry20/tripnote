class Plan < ApplicationRecord
  validates :user_id, presence: true
  validates :plan_title, presence: true
  validates :image, presence: true
  
  belongs_to :user
  has_many :plan_destinations
  mount_uploader :image, ImageUploader
end
