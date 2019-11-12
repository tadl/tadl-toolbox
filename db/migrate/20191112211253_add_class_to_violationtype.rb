class AddClassToViolationtype < ActiveRecord::Migration
  def change
    add_column :violationtypes, :track, :text
  end
end
