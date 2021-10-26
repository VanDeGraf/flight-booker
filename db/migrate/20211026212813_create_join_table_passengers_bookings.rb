class CreateJoinTablePassengersBookings < ActiveRecord::Migration[6.1]
  def change
    create_join_table :bookings, :passengers
  end
end
