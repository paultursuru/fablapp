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

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_users_path, notice: 'Compte supprimé 😢.'
  end
end
