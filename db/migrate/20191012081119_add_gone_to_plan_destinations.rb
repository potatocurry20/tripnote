class AddGoneToPlanDestinations < ActiveRecord::Migration[5.2]
  def change
    add_column :plan_destinations, :gone, :boolean, default: false
  end
end
