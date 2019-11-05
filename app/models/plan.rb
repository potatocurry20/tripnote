class Plan < ApplicationRecord
  validates :user_id, presence: true
  validates :plan_title, presence: true, allow_nil: true
  
  belongs_to :user
  
  #planに紐づくplan_destinationが多数存在する
  has_many :plan_destinations, class_name: "PlanDestination", foreign_key: "plan_id", :dependent => :destroy
  
  #planに紐づくplan_favoritesが多数存在する
  has_many :plan_favorites
  
  #plansテーブルに追加したimageカラムの名前をmount_uploaderに指定する
  mount_uploader :image, ImageUploader
end
