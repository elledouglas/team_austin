class UsersController < ApplicationController

  def index
    @user = User.all

  end
  def new
      @user = User.new
  end

  def show
   @user = User.find(params[:id])
  end



  def create
    @user = User.new(
    email: params[:user][:email],
    password: params[:user][:password]

      )

      respond_to do |format|
       if @user.save
         # Tell the UserMailer to send a welcome email after save
         UserMailer.welcome_email(@user).deliver_now

         format.html { redirect_to(@user, notice: 'User was successfully created.') }
         format.json { render json: @user, status: :created, location: @user }
       else
         format.html { render action: 'new' }
         format.json { render json: @user.errors, status: :unprocessable_entity }
       end
     end
   end
 


    # if @user.save
    #   #session keeps your logged in
    #   # session[:user_id] = @user.id
    #
    #   redirect_to root_path
    # else
    #   flash.now[:alert] = @users.errors.full_messages
    #   render:new
  # end


#   def edit
#   end
#
#   def destroy
#   end
# end
end
