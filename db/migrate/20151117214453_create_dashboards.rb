class CreateDashboards < ActiveRecord::Migration
  def change
    create_table :dashboards do |t|
      t.string :title
      t.string :desc

      t.timestamps null: false
    end
  end
end
