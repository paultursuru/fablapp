class Admin::PagesController < ApplicationController
  before_action :user_admin?

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def index
    @users = User.where(role: 0).includes(:bookings)
    @users_count = @users.count
  end

  def new_user; end

  def add_user
    email = params[:email]
    if User.where(email: email).blank?
      student = User.new(email: email, password: '123456')
    else
      redirect_to admin_new_user_path, alert: "this user already exist !"
      return
    end
    if student.save!
      redirect_to admin_users_path, notice: "#{email}"
    else
      redirect_to admin_new_user_path, alert: "didn't work"
    end
  end

  def reboot_password
    email = params[:email]
    user = User.where(email: email).first
    user.password = "123456"
    redirect_to admin_users_path
    if user.save!
      flash[:notice] = "#{email}'s password was rebooted"
    else
      flash[:alert] = "didn't work"
    end
  end

  def stats
    students = User.where(role: 0)
    formations = Formation.all
    bookings = Booking.all

    @students_count = students.count
    @last_month_students_count = students.where("created_at < ?", (Date.today - 1.months)).count

    @formations_count = formations.count
    @last_month_formation_count = formations.where("created_at < ?", (Date.today - 1.months)).count

    @bookings_count = bookings.count
    @last_month_booking_count = bookings.where("created_at < ?", (Date.today - 1.months)).count
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_users_path, notice: 'Compte supprimé 😢.'
  end
end
