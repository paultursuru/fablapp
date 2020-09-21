class MachinesController < ApplicationController
  def index
    @machines = Machine.all
    @my_machines = current_user.bookings.map(&:machine)
  end

  def show
    @machine = Machine.find(params[:id])
    @booking = Booking.new
  end
end
