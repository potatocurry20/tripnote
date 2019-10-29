class CreateDestinationFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :destination_favorites do |t|
      t.integer :user_id
      t.integer :plan_destination_id

      t.timestamps
    end
  end
end
