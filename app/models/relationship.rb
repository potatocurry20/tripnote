class Relationship < ApplicationRecord
  #「follower」名付けたuserに属する
  belongs_to :follower, class_name: "User"
  #「followed」名付けたuserに属する
  belongs_to :followed, class_name: "User"
  
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
