class BookingsController < ApplicationController
  def index
    @bookings = current_user.bookings
  end

  def create
    booking = Booking.new(booking_params)
    booking.machine_id = params[:machine_id]
    booking.user = current_user
    if booking.save!
      flash[:notice] = 'booking created'
    else
      flash[:alert] = 'error during the booking'
    end
    redirect_to machine_path(params[:machine_id])
  end

  def destroy
  end

  private

  def booking_params
    params.require(:booking).permit(:start_time, :end_time)
  end
end
