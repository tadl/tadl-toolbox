class RemoveUnusedFieldsFromViolations < ActiveRecord::Migration
  def change
    remove_column :suspensions, :track_b_end_date, :date
    remove_column :suspensions, :track_a_end_date, :date
    remove_column :suspensions, :violations_from_date, :date
    remove_column :suspensions, :track_a_id, :integer
    remove_column :suspensions, :track_b_id, :integer
  end
end
