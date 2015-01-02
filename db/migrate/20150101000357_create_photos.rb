class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.attachment :image,   null: false
      t.integer    :band_id, null: false
    end
  end
end
