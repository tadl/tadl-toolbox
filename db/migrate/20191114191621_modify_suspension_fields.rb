class ModifySuspensionFields < ActiveRecord::Migration
  def change
    add_column :suspensions, :violations_from_date, :date
  end
end
