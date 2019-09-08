class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.integer :user_id
      t.string :image
      t.string :plan_title

      t.timestamps
    end
  end
end
