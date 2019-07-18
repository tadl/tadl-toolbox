class AddFieldsToPatronAndIncident < ActiveRecord::Migration
  def change
    add_column :patrons, :no_address, :boolean
    add_column :patrons, :physical_description, :text
    add_column :patrons, :alias, :string
    add_column :incidents, :title, :string
  end
end
