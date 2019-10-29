class DestinationFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :plan_destination
end
