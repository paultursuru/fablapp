class Admin::UsersController < ApplicationController
  before_action :user_admin?

  def formations
    @user = User.find(params[:id])
    @formations = Formation.where(user_id: @user.id)
    @machines_ok = @formations.map { |formation| formation.machine }
    @machines_not_ok = Machine.all - @machines_ok
    @formation = Formation.new
  end
end
