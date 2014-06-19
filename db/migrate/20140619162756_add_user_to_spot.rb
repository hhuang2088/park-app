class AddUserToSpot < ActiveRecord::Migration
  def change
    add_reference :spots, :user, index: true
  end
end
