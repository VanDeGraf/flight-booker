class ParamsSearch < ApplicationRecord
  belongs_to :from_airport, class_name: "Airport"
  belongs_to :to_airport, class_name: "Airport"

  # @return [String]
  def departing_date_formatted
    return nil if departing_date.nil?
    departing_date.strftime("%d/%m/%Y")
  end

  def flights
    Flight.where(
      "from_airport_id = ? AND to_airport_id = ? AND capacity >= ? AND strftime('%d/%m/%Y', departing_time) = ?",
      from_airport_id,
      to_airport_id,
      passengers,
      departing_date_formatted
    )
  end
end
