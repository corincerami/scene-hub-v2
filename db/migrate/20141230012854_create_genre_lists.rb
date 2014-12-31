class CreateGenreLists < ActiveRecord::Migration
  def change
    create_table :genre_lists do |t|
    	t.text    :genres, array: true, null: false
    	t.integer :band_id,            null: false
    end
  end
end
