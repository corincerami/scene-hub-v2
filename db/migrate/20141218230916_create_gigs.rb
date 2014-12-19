class CreateGigs < ActiveRecord::Migration
  def change
    create_table :gigs do |t|
      t.integer :show_id
      t.integer :band_id
    end
  end
end
