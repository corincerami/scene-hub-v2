class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name,     null: false
      t.string :street_1, null: false
      t.string :street_2
      t.string :city,     null: false
      t.string :state,    null: false
      t.string :zip_code, null: false
      t.text   :details
    end
  end
end
