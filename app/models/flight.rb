class Flight < ApplicationRecord
  belongs_to :from_airport, class_name: "Airport", inverse_of: :departing_flights
  belongs_to :to_airport, class_name: "Airport", inverse_of: :arriving_flights
  has_many :bookings

  scope :departing_dates, -> {
    find_by_sql("SELECT DISTINCT(strftime('%d/%m/%Y', departing_time)) as departing_date FROM \"flights\"")
  }

  def travel_time
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

  # @return [String]
  def departing_date_formatted
    departing_time.strftime("%d/%m/%Y")
  end

  def to_s
    dt = "[#{departing_time_local.strftime("%H:%M") }]"
    at = "[#{arriving_time_local.strftime("%H:%M") }]"
    "#{from_airport.code} #{dt} --{ #{travel_time.parts[:hours]} h }--> #{to_airport.code} #{at}"
  end
end
