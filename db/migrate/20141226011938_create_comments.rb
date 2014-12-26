class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.string :title
    	t.text   :body, null: false
    	t.integer :show_id
    	t.integer :user_id
    	t.timestamps
    end
  end
end
