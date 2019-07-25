class AddIncidentpickToIncident < ActiveRecord::Migration
  def change
    add_column :incidents, :incidentpic, :json
  end
end
