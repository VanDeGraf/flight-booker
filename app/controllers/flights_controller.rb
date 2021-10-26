class FlightsController < ApplicationController
  def index
    @flights = nil
    if !params.key?(:commit)
      @search_params = ParamsSearch.new
    else
      @search_params = ParamsSearch.new(search_params)
      @flights = @search_params.flights
    end
  end

  def search_params
    permitted = params.permit(:from_airport, :to_airport, :passengers, :departing_date)
    {
      :from_airport_id => permitted[:from_airport],
      :to_airport_id => permitted[:to_airport],
      :passengers => permitted[:passengers],
      :departing_date => permitted[:departing_date]
    }
  end
end