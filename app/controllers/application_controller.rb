class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :next_bookings, if: :user_signed_in?
  before_action :machines_variables, if: :user_signed_in?

  def next_bookings
    @next_bookings = current_user.bookings.in_the_future.order(start_time: :asc)
    if current_user.admin?
      @admin_today_bookings = Booking.is_today.order(start_time: :asc)
      @admin_tomorrow_bookings = Booking.after_today.order(start_time: :asc)
      @admin_bookings_count = @admin_today_bookings.count + @admin_tomorrow_bookings.count
    else
      @today_bookings = current_user.bookings.is_today.order(start_time: :asc)
      @tomorrow_bookings = current_user.bookings.after_today.order(start_time: :asc)
      @bookings_count = @today_bookings.count + @tomorrow_bookings.count
    end
  end

  def machines_variables
    @online_machines = Machine.online.order(name: :asc)
    @offline_machines = Machine.offline.order(name: :asc) if current_user.admin?
  end

  def on_that_day(this_booking)
    this_user = this_booking.user
    user_bookings = this_user.bookings.where(machine_id: this_booking.machine_id)
    # counting bookings this_day on this_machine in the 11 hours before
    # and 11 hours after (ajusted to this place's opening hours)
    bookings_count = 0
    i = -11
    22.times do
      bookings_count += user_bookings.where(start_time: (this_booking.start_time + i.hours)).count
      i += 1
    end
    bookings_count < 2 # will return true of false
  end

  private

  def user_admin?
    if user_signed_in?
      redirect_to root_path and return unless current_user.admin?
    else
      redirect_to root_path
    end
  end

  protected

  def after_sign_in_path_for(resource)
    # return the path based on resource
    case resource.role
    when 'admin'
      admin_bookings_path
    else
      root_path
    end
  end
end
