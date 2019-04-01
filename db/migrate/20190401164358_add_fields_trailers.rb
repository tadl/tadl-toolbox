class AddFieldsTrailers < ActiveRecord::Migration
  def change
    add_column :trailers, :record_id, :integer
    add_column :trailers, :added_by, :string
    add_column :trailers, :youtube_url, :string
    add_column :trailers, :release_date, :string
    add_column :trailers, :title, :string
    add_column :trailers, :artist, :string
    add_column :trailers, :publisher, :string
    add_column :trailers, :abstract, :text
    add_column :trailers, :item_type, :string
    add_column :trailers, :track_list, :text
    add_column :trailers, :cant_find, :boolean, default: false
  end
end
