class TopicsController < ApplicationController
  before_action do 
    if @topic.nil?
      if !params[:topic].nil?
        @course = Course.find(params[:topic][:course_id])
      else
        @course = Course.find(params[:course_id])
      end
    else
      @course = Course.find(@topic.course_id)
    end
  end
  
  def new
    @topic = Topic.new
  end

  def create
    @topic = @course.topics.build(topic_params)
    if @topic.save
      flash[:success] = "Topic sucessfully added!"
      redirect_to @course
    else
      flash[:danger] = "Topic was unable to be added, please try again"
      redirect_to @course
    end
  end

  def index
    @topics = Topics.all
  end

  def show
  end

  def edit
    @topic = Topic.find(params[:id])
    @attachments = @topic.topic_attachments
    @attachment = @topic.topic_attachments.build
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update_attributes(topic_params)
      flash[:success] = "The topic has successfully been updated"
      redirect_to @course
    else
      flash[:danger] = "Topic update was unsuccessful"
      render 'edit'
    end
  end

  def destroy
    @topic.destroy
    flash[:success] = "Topic has been destroyed"
    redirect_to request.referrer || courses_path
  end
  
  private 
  
    def topic_params
      params.require(:topic).permit(:title, :description, :release_date, :course_id, :relevant_date, topic_attachments_attributes: [:attachment, :topic_id])
    end
end
