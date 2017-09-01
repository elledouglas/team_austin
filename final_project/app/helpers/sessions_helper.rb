# This file was not automatically generated when I think it was supposed to, may have
# set up sessions functionality incorrectly. Manually created this file.
module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Remembers a user in a persistent session.
 def remember(user)
   user.remember
   cookies.permanent.signed[:user_id] = user.id
   cookies.permanent[:remember_token] = user.remember_token
 end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Returns the current logged-in user (if any).
  # def current_user
  #   current_user ||= User.find_by(id: session[:user_id])
  # end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])

        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  # Redirects to stored location (or to the root_path. Per the tutorial it was
  # originally trying to redirect to the "default" path but that was throwing errors for 7 different tests).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || root_path)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  # def check_session
  #   if session == nil
  #     redirect_to root_path
  #   end
  # end



end
