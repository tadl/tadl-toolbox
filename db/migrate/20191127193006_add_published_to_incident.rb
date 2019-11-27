class AddPublishedToIncident < ActiveRecord::Migration
  def change
    add_column :incidents, :published, :boolean, default: false
  end
end
