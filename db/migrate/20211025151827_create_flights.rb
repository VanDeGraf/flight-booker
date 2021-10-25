class CreateFlights < ActiveRecord::Migration[6.1]
  def change
    create_table :flights do |t|
      t.datetime :departing_time
      t.datetime :arriving_time
      t.integer :capacity, default: 300

      t.timestamps
    end
  end
end
