class CreateSoftLocations < ActiveRecord::Migration
  def change
    create_view :soft_locations
  end
end
