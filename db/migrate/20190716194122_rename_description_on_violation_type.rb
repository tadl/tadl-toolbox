class RenameDescriptionOnViolationType < ActiveRecord::Migration
  def change
    rename_column :violationtypes, :descritption, :description
  end
end
