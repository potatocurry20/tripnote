class CreateRecordDestinations < ActiveRecord::Migration[5.2]
  def change
    create_table :record_destinations do |t|
      t.integer :user_id
      t.integer :record_id
      t.string :destination_title
      t.string :image
      t.string :description

      t.timestamps
    end
  end
end
