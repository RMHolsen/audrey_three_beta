module ApplicationHelper
    def logged_in?
      !!session[:user_id]
      #Returns the session if there is one
    end 
  
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
      #Returns the current user if there is one, finding via user.id
    end 
  end