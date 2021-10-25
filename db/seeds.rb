# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

a1 = Airport.create(name: "John F. Kennedy New York", code: "JFK", timezone: -5)
a2 = Airport.create(name: "Hong Kong", code: "HKG", timezone: +8)
a3 = Airport.create(name: "Narita Japan", code: "NRT", timezone: +9)
a4 = Airport.create(name: "Sheremetyevo Moscow", code: "SVO", timezone: +3)
a5 = Airport.create(name: "Toronto Pearson", code: "YYZ", timezone: -5)

# @param from_airport [Airport]
# @param to_airport [Airport]
# @param departing_time [String]
# @param arriving_time [String]
def create_flight(from_airport, to_airport, departing_time, arriving_time)
  Flight.create(departing_time: DateTime.parse(departing_time + utc_offset_to_s(from_airport.timezone)).new_offset(0),
                arriving_time: DateTime.parse(arriving_time + utc_offset_to_s(to_airport.timezone)).new_offset(0),
                from_airport_id: from_airport.id, to_airport_id: to_airport.id)
end

# @param offset_in_h [Integer]
def utc_offset_to_s(offset_in_h)
  d = offset_in_h < 0 ? '-' : '+'
  b_zero = offset_in_h.abs < 10 ? '0' : ''

  "#{d}#{b_zero}#{offset_in_h.abs.to_s}00"
end

create_flight(a1, a4, "20211210T2355", "20211211T1655")
create_flight(a4, a1, "20211101T1455", "20211101T1820")
create_flight(a1, a2, "20211201T0900", "20211202T1400")