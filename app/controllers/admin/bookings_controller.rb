class Admin::BookingsController < ApplicationController
  before_action :user_admin?

  def index
    # variables defined in application_controller
  end

  def past_bookings
    @admin_past_today_bookings = Booking.in_the_past.is_past_today.order(start_time: :desc)
    @admin_past_bookings = Booking.in_the_past.before_today.last_week.order(start_time: :desc)
    @admin_past_bookings_count = @admin_past_today_bookings.count + @admin_past_bookings.count
  end
end
