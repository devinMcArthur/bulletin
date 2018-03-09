class CoursesController < ApplicationController
  
  before_action :logged_in_user,  only: [:new, :create, :edit, :update, :destroy, :show]
  before_action :check_professor, only: [:new, :create, :edit, :update, :destroy]
  before_action :check_approval,  only: [:show]

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.build(course_params)
    @course.update_attributes(admin_id: current_user.id)
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
    
    @assignment = @course.assignments.build
    @assignments = @course.assignments.paginate(page: params[:page])
    
    @requests = @course.requests.paginate(page: params[:page])
    
    @attachment = @assignment.assignment_attachments.build
    
    @attachments = []
    
    @assignments.each do |a|
      @attachments << AssignmentAttachment.find_by(assignment_id: a.id)
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(course_params)
      flash[:success] = "The course has successfully been updated"
      redirect_to @course
    else
      render 'edit'
    end
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
    
    def check_ownership?
      if @course.admin_id == current_user.id
        return true
      else
        return false
      end
    end
    
    def logged_in_user
      if current_user.nil?
        flash[:danger] = "Must be logged in to do this action!"
        redirect_to login_path
      end
    end
    
    def check_approval
      @course = Course.find(params[:id])
      if !Request.where(course_id: @course.id, user_id: current_user.id, approved: true).exists? 
        if check_ownership?
         return 
        end
        flash[:danger] = "You are not enrolled in this course"
        redirect_to courses_path
      end
    end
  
end
