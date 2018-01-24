class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Login functionality
      log_in user
      redirect_to user
    else
      # Error message if login unsuccessful
      flash.now[:danger] = "Invalid login information"
      render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
    
end
