class ChangeCreatedByToAdminId < ActiveRecord::Migration
  def change
  	rename_column :lists, :created_by, :admin_id
  end
end
