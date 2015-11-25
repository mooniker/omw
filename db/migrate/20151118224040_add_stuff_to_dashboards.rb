class AddStuffToDashboards < ActiveRecord::Migration
  # really great, I love that you created additional migrations to update your schema
  # rather than edit existing migrations.
  def change
    add_column :dashboards, :public, :boolean
    add_column :dashboards, :address, :string
    add_column :dashboards, :lat, :decimal
    add_column :dashboards, :lon, :decimal
  end
end
