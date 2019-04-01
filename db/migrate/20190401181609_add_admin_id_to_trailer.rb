class AddAdminIdToTrailer < ActiveRecord::Migration
  def change
    add_column :trailers, :admin_id, :integer
  end
end

