class BookingsController < ApplicationController
  def new
    redirect_to root_path unless params.key?(:params_search)

    permitted = params.require(:params_search).permit(:flights, :passengers)
    @flight = Flight.find(permitted[:flights].to_i)
    @booking = Booking.new
    permitted[:passengers].to_i.times { @booking.passengers.build }
  end

  def create
    redirect_to new_booking_path unless params.key?(:booking)

    permitted = params.require(:booking).permit(:flight_id, :passengers_attributes => {})
    @booking = Booking.new(flight_id: permitted[:flight_id].to_i)
    permitted[:passengers_attributes].each do |i, pa|
      founded = Passenger.find_by(email: pa[:email])
      if founded.nil?
        @booking.passengers.build(pa)
      else
        @booking.passengers << founded
      end
    end
    @booking.save
    redirect_to booking_path(@booking)
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def index
    @bookings = Booking.all.order(:created_at)
  end
end