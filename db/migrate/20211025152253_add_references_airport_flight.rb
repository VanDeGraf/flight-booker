class AddReferencesAirportFlight < ActiveRecord::Migration[6.1]
  def change
    change_table :flights do |t|
      t.references :from_airport, foreign_key: { to_table: :airports }
      t.references :to_airport, foreign_key: { to_table: :airports }
    end
  end
end
