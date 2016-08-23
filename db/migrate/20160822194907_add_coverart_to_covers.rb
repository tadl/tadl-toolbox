class AddCoverartToCovers < ActiveRecord::Migration
  def change
    add_column :covers, :coverart, :string
  end
end
