class CreateSoftstatsReportingView < ActiveRecord::Migration
  def change
    create_view :softstats_reporting_view
  end
end
