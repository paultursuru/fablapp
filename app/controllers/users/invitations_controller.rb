class Users::InvitationsController < Devise::InvitationsController
  skip_before_action :authenticate_user!, only: [:edit, :update]
  before_action :user_admin?, only: [:new, :create, :destroy]

  def new
    current_user.invitation_limit = 1
    current_user.save
    super
  end
end
