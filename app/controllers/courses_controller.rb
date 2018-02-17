class CoursesController < ApplicationController
  
  before_action :logged_in_user,  only: [:new, :create, :edit, :update, :destroy]
  before_action :check_professor, only: [:new, :create, :edit, :update, :destroy]

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.build(course_params)
    if @course.save
      # Handle sucessful course additions
      flash[:sucess] = "Your course has sucessfully been added!"
      redirect_to courses_path
    else
      # Handle unsucessful course additions
      render 'new'
    end
  end

  # Index of all courses
  def index
    @course_feed = Course.all.paginate(page: params[:page])
  end
  
  # Show a particular Course
  def show
    @course = Course.find(params[:id])
  end

  def edit
  end

  def update
    @course = Course.find(params[:id])
    @course.update_attributes(update_params)
  end

  def destroy
    @course = Course.find(params[:id])
    if !@course.nil?
      @course.destroy
      flash[:success] = "Course successfully deleted!"
      redirect_to request.referrer || courses_path
    else 
      flash[:danger] = "Course could not be found"
      redirect_to request.referrer || courses_path
    end
  end
  
  private
  
    def course_params
      params.require(:course).permit(:title, :description, :code, :section, :admin, :admin_id, :start_date, :end_date)
    end
    
    def update_params
      params.require(:course).permit(:admin, :admin_id, :start_date, :end_date)
    end
  
    def check_professor
      if current_user.professor == false
        flash[:danger] = "Must be a Professor to create a course"
        redirect_to root_url
      end
    end
    
    def logged_in_user
      if current_user.nil?
        flash[:danger] = "Must be logged in to do this action!"
        redirect_to login_path
      end
    end
  
end
