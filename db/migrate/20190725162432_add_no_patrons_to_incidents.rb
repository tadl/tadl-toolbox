class AddNoPatronsToIncidents < ActiveRecord::Migration
  def change
    add_column :incidents, :no_patrons, :boolean
  end
end
