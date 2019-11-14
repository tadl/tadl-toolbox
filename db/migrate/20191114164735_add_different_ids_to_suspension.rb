class AddDifferentIdsToSuspension < ActiveRecord::Migration
  def change
    add_column :suspensions, :track_a_id, :integer
    add_column :suspensions, :track_b_id, :integer
  end
end
