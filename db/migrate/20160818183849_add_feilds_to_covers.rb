class AddFeildsToCovers < ActiveRecord::Migration
  def change
  	add_column :covers, :title, :text
  	add_column :covers, :artist, :text
  	add_column :covers, :publisher, :string
  	add_column :covers, :release_date, :string
  	add_column :covers, :item_type, :string
  	add_column :covers, :track_list, :text
  	add_column :covers, :abstract, :text
  end
end
