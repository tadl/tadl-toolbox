class AddCreateAndUpdateToTrailers < ActiveRecord::Migration
  def change
    add_column :trailers, :created_at, :datetime, null: false
    add_column :trailers, :updated_at, :datetime, null: false
  end
end
