class MachinesController < ApplicationController
  def index
    @my_machines = current_user.machines.uniq
  end

  def show
    @machine = Machine.find(params[:id])
    return redirect_to machines_path if (!@machine.visible || current_user.formations.where(machine: @machine).empty?) && !current_user.admin?

    @booking = Booking.new
  end
end
