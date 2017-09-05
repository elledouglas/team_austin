class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  # def current_user
  #   session[:user_id] && User.find(session[:user_id])
  # end

  private

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location # This line uses a method in sessions_helper to store request location so that it may redirect them to that location upon login.
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

end
