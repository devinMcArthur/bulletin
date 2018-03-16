class StaticPagesController < ApplicationController
  def home
    @courses = Course.all.paginate(page: params[:page])
    @user = User.new
    if logged_in?
      if current_user.professor == true
        @prof_courses = Course.where(admin_id: current_user.id).all
        @prof_assignments = Assignment.where(course_id: @prof_courses.ids).order("due_date ASC")
        @prof_assignments_feed = Assignment.where(course_id: @prof_courses.ids, due_date: [Time.now .. Time.now + 7.days]).all.order("due_date ASC")
      else
        @student_courses = current_user.courses
        @student_assignments = Assignment.where(course_id: @student_courses.ids).order("due_date ASC")
        @student_assignments_feed = Assignment.where(course_id: @student_courses.ids, due_date: [Time.now .. Time.now + 7.days]).all.order("due_date ASC")
      end
    end
  end

  def help
  end

  def about
  end
  
  def contact
  end
end
