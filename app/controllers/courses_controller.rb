class CoursesController < ApplicationController
  
  before_action :logged_in_user,  only: [:new, :create, :edit, :update, :destroy, :show]
  before_action :check_approval,  only: [:show]

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.build(course_params)
    @course.update_attributes(admin_id: current_user.id)
    if @course.save
      if @course.public == false
        if current_user.professor == false
          current_user.courses << @course
        end
      end
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
    if !current_user.nil?
      @user_courses = current_user.courses.paginate(page: params[:page])
    end
    @course_feed = Course.where(public: true).all.paginate(page: params[:page])
  end
  
  # Show a particular Course
  def show
    @course = Course.find(params[:id])
    
    @assignment = @course.assignments.build
    @assignments = @course.assignments.paginate(page: params[:page]).order("due_date ASC")
    
    @topic = @course.topics.build
    @topics = @course.topics.paginate(page: params[:page]).order("relevant_date ASC")
    
    @requests = @course.requests.paginate(page: params[:page])
    
    @assignment_attachment = @assignment.assignment_attachments.build
    # Create an array with all related attachments
    @assignment_attachments = []
    @assignments.each do |a|
      b = AssignmentAttachment.where(assignment_id: a.id)
      b.each do |f|
        @assignment_attachments << f
      end
    end
    
    @topic_attachment = @topic.topic_attachments.build
    @topic_attachments = []
    @topics.each do |a|
      b = TopicAttachment.where(topic_id: a.id)
      b.each do |f|
        @topic_attachments << f
      end
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(course_params)
      if @course.public == false
        if current_user.professor == false
          if !current_user.courses.exists?(@course.id)
            current_user.courses << @course
          end
        end
      end
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
      params.require(:course).permit(:title, :description, :code, :section, :admin, :admin_id, :start_date, :end_date, :public)
    end
    
    def update_params
      params.require(:course).permit(:admin, :admin_id, :start_date, :end_date, :public)
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
