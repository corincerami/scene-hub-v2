class ChangeGenreLists < ActiveRecord::Migration
  def change
    change_table :genre_lists do |t|
      t.string :genre,    null: false
    end

    remove_column :genre_lists, :genres, :text, array: true, null: false
  end
end
