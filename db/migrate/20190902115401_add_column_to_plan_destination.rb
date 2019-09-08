class AddColumnToPlanDestination < ActiveRecord::Migration[5.2]
  def change
    add_column :plan_destinations, :description, :string
  end
end
