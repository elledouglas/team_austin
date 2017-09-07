class WinksController < ApplicationController
  before_action :logged_in_user

  def create
    user = User.find(params[:wink_recipient_id])
    current_user.wink_at(user)
    redirect_to user_profile_path(@current_user.id)

    #wink.valid? Redirect_to
  end



end
