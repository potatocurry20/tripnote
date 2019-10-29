class PlanDestination < ApplicationRecord
  validates :user_id, presence: true
  validates :plan_id, presence: true
  validates :destination_title, presence: true, allow_nil: true
  validates :description, presence: true, allow_nil: true
  
  belongs_to :user
  belongs_to :plan
  has_many :destination_favorites, dependent: :destroy
  has_many :favorite_users, through: :destination_favorites, source: 'user'
  mount_uploader :image, ImageUploader
end
