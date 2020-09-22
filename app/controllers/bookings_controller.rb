class BookingsController < ApplicationController
  def index
    @bookings = current_user.bookings.in_the_future
  end

  def create
    unless current_user.admin?
      if current_user.bookings.in_the_future.count > 2
        flash[:alert] = 'already too much bookings'
        return redirect_to root_path
      end
    end

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
    booking = Booking.find(params[:id])
    booking.destroy
    redirect_to bookings_path
    flash[:notice] = 'booking was succesfully cancelled'
  end

  private

  def booking_params
    params.require(:booking).permit(:start_time, :end_time)
  end
end
