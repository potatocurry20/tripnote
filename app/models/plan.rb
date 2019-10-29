class Plan < ApplicationRecord
  validates :user_id, presence: true
  validates :plan_title, presence: true, allow_nil: true
  
  belongs_to :user
  has_many :plan_destinations, :dependent => :destroy
  has_many :plan_favorites
  mount_uploader :image, ImageUploader
end
