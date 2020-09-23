class Admin::BookingsController < ApplicationController
  before_action :user_admin?

  def index

  end
end
