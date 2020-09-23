class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :next_bookings, if: :user_signed_in?
  before_action :machines_variables, if: :user_signed_in?

  def next_bookings
    @next_bookings = current_user.bookings.in_the_future.order(start_time: :asc)
    if current_user.admin?
      @admin_today_bookings = Booking.is_today.order(start_time: :asc)
      @admin_tomorrow_bookings = Booking.after_today.order(start_time: :asc)
    else
      @today_bookings = current_user.bookings.is_today.order(start_time: :asc)
      @tomorrow_bookings = current_user.bookings.after_today.order(start_time: :asc)
    end
  end

  def machines_variables
    @online_machines = Machine.online.order(name: :asc)
    @offline_machines = Machine.offline.order(name: :asc) if current_user.admin?
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
