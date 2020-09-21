class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :next_bookings, if: :user_signed_in?
  before_action :machines_variables, if: :user_signed_in?

  def next_bookings
    @next_bookings = current_user.bookings.in_the_future.order(start_time: :asc)
  end

  def machines_variables
    @online_machines = Machine.online
    @offline_machines = Machine.offline
  end
end
