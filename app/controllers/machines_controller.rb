class MachinesController < ApplicationController
  def index
    @my_machines = current_user.machines.uniq
  end

  def show
    @machine = Machine.find(params[:id])
    @booking = Booking.new
  end
end
