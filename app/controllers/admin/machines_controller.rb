class Admin::MachinesController < ApplicationController
  before_action :user_admin?
  before_action :find_machine, only: [:edit, :update, :destroy]

  def index
  end

  def show
    @booking = Booking.new
  end

  def new
    @machine = Machine.new
  end

  def create
    @machine = Machine.new(machine_params)
    if @machine.save
      redirect_to admin_machines_path
      flash[:notice] = 'Machine created'
    else
      render :new
      flash[:alert] = 'Error during creation..'
    end
  end

  def edit; end

  def update
    if @machine.update(machine_params)
      redirect_to admin_machines_path
      flash[:notice] = 'Machine updated'
    else
      render :edit
      flash[:alert] = 'Error during update..'
    end
  end

  def destroy
    @machine.destroy
    redirect_to admin_machines_path
  end

  private

  def machine_params
    params.require(:machine).permit(:name, :description, :visible)
  end

  def find_machine
    @machine = Machine.find(params[:id])
  end
end
