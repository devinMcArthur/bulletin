class RequestsController < ApplicationController
  
  def new
    @request = Request.new(request_params)
    if @request.save
      flash[:success] = "You have sucessfully requested your enrollment"
      redirect_to request.referrer || courses_path
    else
      flash[:danger] = "Request was unable to be sent"
      redirect_back
    end
  end
  
  def create
    @request = Request.new(request_params)
    if @request.save
      flash[:success] = "You have sucessfully requested your enrollment"
      redirect_to request.referrer || courses_path
    else
      flash[:danger] = "Request was unable to be sent"
      redirect_back
    end
  end

  def show
  end

  def index
    @requests = Request.where(user_id: current_user.id).paginate(page: params[:page])
  end

  def update
    @request = Request.find(params[:id])
    @request.update_attributes(update_params)
    redirect_to request.referrer || courses_path
    @course = Course.find_by(id: @request.course_id)
    @user = User.find_by(id: @request.user_id)
    if @request.approved == true
      @user.courses << @course
    elsif
      @user.courses.delete(@course)
    end
  end

  def edit
    @request = Request.find(params[:id])
  end
  
  def destroy
   @request = Request.find(params[:id])
   @user = User.find_by(id: @request.user_id)
   @course = Course.find_by(id: @request.course_id)
   @user.courses.delete(@course)
   @request.destroy
   redirect_to request.referrer || current_user
  end
  
  private 
    def request_params
      params.permit(:course_id, :user_id, :approved)
    end
    
    def update_params
      params.require(:request).permit(:course_id, :user_id, :approved)
    end
end
