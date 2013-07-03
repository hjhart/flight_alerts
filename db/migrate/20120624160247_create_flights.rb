class CreateFlights < ActiveRecord::Migration
  def up
    create_table :flights do |t|
      t.datetime :takeoff
      t.integer :length_in_minutes
      t.datetime :landing
      t.string :airline
      t.integer :price_in_us_dollars
      t.timestamps
    end
  end

  def down
    drop_table :flights
  end
end
