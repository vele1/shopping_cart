class LoginController < ApplicationController
  skip_before_filter :check_authentication, :check_authorization
  layout "welcome"

  def index
    redirect_to :action => :login
  end

  # Login user.
  def login
    if request.post?
      user = User.try_to_login(params[:user][:username], params[:user][:password])
      if user
        # save user id on session and redirect to list categories.
        session[:user_id] = user.id
        if user.admin?
          redirect_to :controller => "categories"
        else
          redirect_to :controller => "store"
        end
      else
        flash.now[:notice] = "Invalid username or password"
        render :action => :login
      end
    end
  end

  # Logout user.
  def logout
    session[:user_id] = nil
    flash[:notice] = "You have been logged out"
    redirect_to :action => :login
  end

  # Register new user.
  def register
    if request.post?
      @user = User.new(params[:user])
      @user.password = params[:password]
      if @user.save
        flash[:notice] = "You profile has been created successfully"
        session[:user_id] = @user.id
        redirect_to :controller => "store"
      else
        render :action => 'register'
      end
    end
  end
end
