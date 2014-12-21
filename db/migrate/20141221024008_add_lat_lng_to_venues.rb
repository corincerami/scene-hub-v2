class AddLatLngToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :lat, :float, null: false, default: 0.0
    add_column :venues, :lng, :float, null: false, default: 0.0
  end
end
