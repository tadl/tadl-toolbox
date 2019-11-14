class AddTrackToSuspension < ActiveRecord::Migration
  def change
    add_column :suspensions, :track, :text
  end
end
