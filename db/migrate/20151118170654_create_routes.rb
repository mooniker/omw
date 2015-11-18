class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :LineDescription
      t.string :Name
      t.string :RouteID

      t.timestamps null: false
    end
  end
end
