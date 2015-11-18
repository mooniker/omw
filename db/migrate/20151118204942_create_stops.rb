class CreateStops < ActiveRecord::Migration
  def change
    # {"Stops": [{"Lat": 38.670006, "StopID": "3000037", "Lon": -77.010283, "Name": "LIVINGSTON RD + INDIAN HEAD HWY", "Routes": ["W19"]},

    create_table :stops do |t|
      t.decimal :Lat
      t.string :StopID
      t.decimal :Lon
      t.string :Name
      t.timestamps null: false
    end

    create_table :connections do |t|
      t.belongs_to :route
      t.belongs_to :stop
    end
  end
end
