class AddStuffToDashboards < ActiveRecord::Migration
  def change
    add_column :dashboards, :public, :boolean
    add_column :dashboards, :address, :string
    add_column :dashboards, :lat, :decimal
    add_column :dashboards, :lon, :decimal
  end
end
