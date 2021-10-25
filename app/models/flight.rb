class Flight < ApplicationRecord
  belongs_to :from_airport, class_name: "Airport", inverse_of: :departing_flights
  belongs_to :to_airport, class_name: "Airport", inverse_of: :arriving_flights

  def travel_time_hours
    elapsed = arriving_time - departing_time
    ActiveSupport::Duration.build(elapsed)
  end

  # @param utc_offset [Integer]
  # @return [Time]
  def departing_time_local(utc_offset = from_airport.timezone)
    departing_time.localtime(utc_offset * 3600)
  end

  # @param utc_offset [Integer]
  # @return [Time]
  def arriving_time_local(utc_offset = to_airport.timezone)
    arriving_time.localtime(utc_offset * 3600)
  end
end
