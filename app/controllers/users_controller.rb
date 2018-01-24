class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Bulletin!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  private
    
    # This is used to prevent users from passing raw paramaters in a web request, but will always require the :user attribute
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  
end
