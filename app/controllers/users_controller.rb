class UsersController < ApplicationController
  # \/ Requires user to be logged in before editing, updating, or viewing index
    before_action :logged_in_user, only: [:index, :edit, :update, :blocking]

  # \/ Requires that one be the user of the profile page one is trying to edit or destroy
    before_action :correct_user,   only: [:edit, :update, :destroy, :blocking]

  # \/ Reqires that current_user not be blocked by show-page user in order to view their show page
    # before_action :user_not_blocked, only: :show

# enable :sessions
    # For secured endpoints only
    #config.client_ips = '<Comma separated list of IPs>'


  def index
    if current_user.sexual_preference == "male" && current_user.gender == "male"
        @users = User.where(gender: "male").where(sexual_preference: "male")
    elsif  current_user.sexual_preference == "female" && current_user.gender == "female"
            @users = User.where(gender: "female").where(sexual_preference: "female")
   else
      @users = User.where(gender: current_user.sexual_preference)
  end

  if params[:search].present?
    if params[:search][:age_from].present? && params[:search][:age_to].present?
      @users = @users.where("age > ? and age < ?",params[:search][:age_from].to_i,params[:search][:age_to].to_i)
    elsif params[:search][:children].present? && params[:search][:children] == "yes"
      @users = @users.where.not(children: "")
    elsif params[:search][:height_from].present? && params[:search][:height_to].present?
      @users = @users.where("height > ? and height < ?",params[:search][:height_from], params[:search][:height_to])
    elsif params[:search][:ethnicity].present?
      @users = @users.where(ethnicity: params[:search][:ethnicity])
    end
  end
end


  def new
      @user = User.new
  end

  def show
   @user = User.find(params[:id])
   @users = @user.wink_senders
   @insta_feed = Instagram.client(:access_token => @user.instagram_token)
  #  # debugger      #(<----uncomment to use byebug in server)
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
        if @user.save
         log_in @user
         flash[:success] = "User Profile Successfully Created"
         # Tell the UserMailer to send a welcome email after save
        #  UserMailer.welcome_email(@user).deliver_now

        #  if @user.sexual_preference == "m4f"
        #    render 'm4f'
        #  elsif @user.sexual_preference == "f4m"
        #    render 'f4m'
        #  elsif @user.sexual_preference == "m4m"
        #    render 'm4m'
        #  else @user.sexual_preference == "f4f"
        #      render 'f4f'
        #    end}
          format.html { redirect_to(users_path, notice: 'User was successfully created.') }
          format.json { render json: @user, status: :created, location: @user }
        else
          format.html { render action: 'new' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
  end


   def edit
     @user = User.find(params[:id])  # Could technically delete this line because of the correct_user user method and filter? (line 5)
   end

  def update
    @user = User.find(params[:id])  # Could technically delete this line because of the correct_user user method and filter? (line 5)
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to user_profile_path(@user)
    else
      render 'edit'
    end

  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "You have deleted your account, including all profile information!"
    redirect_to users_url
  end

  # def blocking
  #   @title = "Blocking"
  #   @user  = User.find(params[:id])
  #   @users = @user.blocking
  #   render 'show_block'
  # end

  # Instagram callback in process
   def instagramadd
     redirect_to Instagram.authorize_url(:redirect_uri => "http://localhost:3000/users/oauth/callback")
   end

   def instagram_callback
     response = Instagram.get_access_token(params[:code], :redirect_uri => "http://localhost:3000/users/oauth/callback")
    if current_user
      current_user.instagram_token = response.access_token
    if current_user.save
    redirect_to user_profile_path(current_user.id)
    end
    end

   end

  # User can send email to another user
def send_email
  UserMailer.send_message(params[:id],params[:message][:message]).deliver_now

  render html: 'You sent a message'
end

def wink
  UserMailer.send_message(params[:id],"You've been winked at ...").deliver_now
  render img
end



#   html = "<h1>#{user.username}'s recent photos</h1>"
#   for media_item in client.user_recent_media
#     html << "<img src='#{media_item.images.thumbnail.url}'>"
#   end
#   html
# end

  private


   def user_params
     params.require(:user).permit(:full_name, :gender, :age, :ethnicity, :children, :occupation, :email, :password, :video, :image, :password_confirmation, :sexual_preference)
   end


  # \/ Before filters

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(login_url) unless current_user?(@user)
  end

  # Filter method that disallows access to show page owner if they have blocked current user.
  def user_not_blocked
    @user = User.find(params[:id])
    if @user.blocking?(current_user)
    # unless not_blocked?
      flash[:danger] = "You have been blocked by #{@user.full_name}"
      redirect_to users_path
    end
  end

  # def blocking                # Don't remember what this was for.
  #   @title = "Blocking"
  #   @user  = User.find(params[:id])
  #   @users = @user.blocking
  # end

  def winks_received
    @user  = User.find(params[:id])
    @users = @user.wink_senders
    render 'show_wink_senders'
  end

  # Confirms that current_user is not blocked by @user
  # def user_not_blocked
  #   unless not_blocked?
  #     flash[:danger] = "You have been blocked by #{@user.full_name}."
  #     redirect_to users_path
  #   end
  # end
  #
  # def not_blocked?
  #   @user = User.find(params[:id])
  #   current_user != @user.blocking?(current_user)
  # end



  # Confirms a logged-in user.
  # def logged_in_user
  #   unless logged_in?
  #     store_location # This line uses a method in sessions_helper to store request location so that it may redirect them to that location upon login.
  #     flash[:danger] = "Please log in."
  #     redirect_to login_url
  #   end
  # end
  #
  # # Confirms the correct user.
  # def correct_user
  #   @user = User.find(params[:id])
  #   redirect_to(root_url) unless current_user?(@user)
  #

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(login_url) unless current_user?(@user)
  end

end
