class CreateParamsSearches < ActiveRecord::Migration[6.1]
  def change
    create_table :params_searches do |t|
      t.date :departing_date
      t.integer :passengers, default: 1
      t.references :from_airport, foreign_key: { to_table: :airports }
      t.references :to_airport, foreign_key: { to_table: :airports }

      t.timestamps
    end
  end
end
