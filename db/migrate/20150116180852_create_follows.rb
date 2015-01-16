class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :band_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
