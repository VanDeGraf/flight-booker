class CreateAirports < ActiveRecord::Migration[6.1]
  def change
    create_table :airports do |t|
      t.string :name
      t.string :code
      t.integer :timezone

      t.timestamps
    end
  end
end
