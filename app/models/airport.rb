class Airport < ApplicationRecord
  has_many :departing_flights, foreign_key: :from_airport_id, class_name: "Flight", inverse_of: :from_airport
  has_many :arriving_flights, foreign_key: :to_airport_id, class_name: "Flight", inverse_of: :to_airport
end
