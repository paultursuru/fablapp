class Admin::UsersController < ApplicationController
  before_action :user_admin?
end
