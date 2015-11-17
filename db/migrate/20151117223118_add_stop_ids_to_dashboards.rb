class AddStopIdsToDashboards < ActiveRecord::Migration
  def change
    add_column :dashboards, :stop_id_str, :string
  end
end
