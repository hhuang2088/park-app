class ChangeCoordinateDataType < ActiveRecord::Migration
  def change
    change_column :spots, :longitude, :float 
    change_column :spots, :latitude, :float
  end
end
