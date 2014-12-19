class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.text     :details
      t.datetime :show_date, null: false
      t.integer  :venue_id,  null: false
    end
  end
end
