class UsersController < ApplicationController

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
         log_in @user
         flash[:success] = "User Profile Successfully Created"
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

   def edit
     @user = User.find(params[:id])
   end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to user_profile_path(@user)
    else
      render 'edit'
    end
  end

  private

   def user_params
     params.require(:user).permit(:full_name, :email, :password,
                                  :password_confirmation)
   end

end
