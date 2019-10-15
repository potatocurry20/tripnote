class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  belongs_to :plan_destination
end
