class BookingsController < ApplicationController
  def index
    @bookings = current_user.bookings.in_the_future
  end

  def create
    unless current_user.admin?
      if current_user.bookings.in_the_future.count > 10
        flash[:alert] = 'already too much bookings'
        return redirect_to root_path
      end
    end

    booking = Booking.new(booking_params)
    booking.machine_id = params[:machine_id]
    booking.user = current_user
    if booking.start_time + 1.hours != booking.end_time
      flash[:alert] = 'Nice try.'
      return redirect_to root_path
    end
    unless on_that_day(booking)
      flash[:alert] = "You already book the #{booking.machine.name} twice this day"
      return redirect_to root_path
    end
    unless current_user.bookings.where(start_time: booking.start_time).empty?
      flash[:alert] = "Looks like you already booked #{current_user.bookings.where(start_time: booking.start_time).last.machine.name} that day at #{booking.start_time.strftime("%H:00")}.. You can't book two machines at the same time."
      return redirect_to root_path
    end
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
