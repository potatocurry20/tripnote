class CreatePlanDestinations < ActiveRecord::Migration[5.2]
  def change
    create_table :plan_destinations do |t|
      t.integer :user_id
      t.integer :plan_id
      t.string :destination_title
      t.string :image

      t.timestamps
    end
  end
end
