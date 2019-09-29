class Plan < ApplicationRecord
  validates :user_id, presence: true
  validates :plan_title, presence: true, allow_nil: true
  validates :image, presence: true, allow_nil: true
  
  belongs_to :user
  has_many :plan_destinations, :dependent => :destroy
  mount_uploader :image, ImageUploader
end
