class UpdateSoftLocationsToVersion2 < ActiveRecord::Migration
  def change
    update_view :soft_locations, version: 2, revert_to_version: 1
  end
end
