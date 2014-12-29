class CreateBandPosts < ActiveRecord::Migration
  def change
    create_table :band_posts do |t|
    	t.string  :title,      null: false
    	t.text    :content,    null: false
    	t.integer :band_id,    null: false
    	t.timestamps
    end
  end
end
