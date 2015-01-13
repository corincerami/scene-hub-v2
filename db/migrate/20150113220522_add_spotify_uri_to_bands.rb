class AddSpotifyUriToBands < ActiveRecord::Migration
  def change
    add_column :bands, :spotify_uri, :string
  end
end
