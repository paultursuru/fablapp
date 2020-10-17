class Admin::FormationsController < ApplicationController
  before_action :user_admin?

  def formation_toggle
    user = User.find(params[:user])
    machine = Machine.find(params[:machine])
    if user.formations.where(machine: machine).count == 1
      formation = user.formations.where(machine: machine).first
      formation.destroy
    else
      formation = Formation.new
      formation.machine_id = params[:machine]
      formation.user_id = params[:user]
      formation.save
    end
    redirect_to admin_user_formations_path(params[:user])
  end
end
