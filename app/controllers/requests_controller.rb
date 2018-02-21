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
  end

  def update
  end

  def edit
  end
  
  private 
    def request_params
      params.permit(:course_id, :user_id, :approved)
    end
end
