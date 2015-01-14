class AddSoundcloudUrlToBands < ActiveRecord::Migration
  def change
    add_column :bands, :soundcloud_url, :string
  end
end
