class StaticPagesController < ApplicationController
  def home
    @courses = Course.all.paginate(page: params[:page])
    @user = User.new
    if logged_in?
      if current_user.professor == true
        @prof_courses = Course.where(admin_id: current_user.id).all
        @prof_assignments_feed = Assignment.where(course_id: @prof_courses.ids, due_date: [Time.now .. Time.now + 7.days])
        @prof_assignments = Assignment.where(course_id: @prof_courses.ids)
      else
        @student_courses = current_user.courses
        @student_assignments_feed = Assignment.where(course_id: @student_courses.ids, due_date: [Time.now .. Time.now + 7.days])
        @student_assignments = Assignment.where(course_id: @student_courses.ids)
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
