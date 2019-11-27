class AddAdminIdToIncident < ActiveRecord::Migration
  def change
    add_column :incidents, :admin_id, :integer
  end
end
