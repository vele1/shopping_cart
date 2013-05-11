# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  # Make these methods available to our views
  helper_method :current_user

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

   before_filter :check_authentication, :check_authorization

   def check_authentication
     unless session[:user_id]
       redirect_to :controller => "login", :action => "login" and return false
     end
   end

   # Check authorizations of users
   def check_authorization
     person = User.find(session[:user_id])
     if %w{product category }.include?(controller_name) && !person.admin?
       flash.now[:error] = "You are not authorized to view the page requested"
       redirect_to :controller => "login", :action => "login" and return false
     end
   end

   # Return current user
   def current_user
     User.find(session[:user_id])
   end
end
