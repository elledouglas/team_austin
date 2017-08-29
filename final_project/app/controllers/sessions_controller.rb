class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      log_in user
      session[:user_id] = user.id
      flash[:notice] = 'Successfully logged in!'
      redirect_to root_url
    else
      flash.now[:danger] = ["Login failed, email and/or password are incorrect"]
      render :new
    end
  end

  def destroy
    log_out
    redirect_to(:root, notice: 'Logged out!')
  end

end
