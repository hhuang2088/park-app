class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
      t.integer :longitude
      t.integer :latitude
      t.text :description

      t.timestamps
    end
  end
end
