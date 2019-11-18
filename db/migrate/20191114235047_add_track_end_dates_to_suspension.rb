class AddTrackEndDatesToSuspension < ActiveRecord::Migration
  def change
    add_column :suspensions, :track_a_end_date, :date
    add_column :suspensions, :track_b_end_date, :date
  end
end
