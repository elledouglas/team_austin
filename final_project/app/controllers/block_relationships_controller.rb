class BlockRelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    user = User.find(params[:blocked_id])
    current_user.block(user)
    redirect_to edit_user_profile_path
  end

  def destroy
    user = BlockRelationship.find(params[:id]).blocked
    current_user.unblock(user)
    redirect_to edit_user_profile_path
  end
end
