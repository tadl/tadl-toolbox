class CreateSoftStatnames < ActiveRecord::Migration
  def change
    create_view :soft_statnames
  end
end
