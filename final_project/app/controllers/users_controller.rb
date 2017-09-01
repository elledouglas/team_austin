class UsersController < ApplicationController

enable :sessions
    # For secured endpoints only
    #config.client_ips = '<Comma separated list of IPs>'
  end

  def index
        @user = User.all
  end

  def new
      @user = User.new
  end

  def show
   @user = User.find(params[:id])
  #  debugger           #(<----uncomment to use byebug in server)
  end

  def create
    @user = User.new(user_params)

      respond_to do |format|
       if @user.save
         # Tell the UserMailer to send a welcome email after save
         UserMailer.welcome_email(@user).deliver_now

         format.html { redirect_to(users_path, notice: 'User was successfully created.') }
         format.json { render json: @user, status: :created, location: @user }
       else
         format.html { render action: 'new' }
         format.json { render json: @user.errors, status: :unprocessable_entity }
       end
     end
   end

   def instagramadd
     redirect_to Instagram.authorize_url(:redirect_uri => 'localhost:3000/users/instagram/callback')
   end

def send_email
  UserMailer.send_message(params[:id],params[:message][:message]).deliver_now

  render html: 'You sent a message'
end



  html = "<h1>#{user.username}'s recent photos</h1>"
  for media_item in client.user_recent_media
    html << "<img src='#{media_item.images.thumbnail.url}'>"
  end
  html
end
  private

   def user_params
     params.require(:user).permit(:full_name, :email, :password, :video, :image,:password_confirmation)
   end


end
