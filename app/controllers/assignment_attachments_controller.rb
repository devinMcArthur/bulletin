class AssignmentAttachmentsController < ApplicationController
  
  def new 
    @attachment = AssignmentAttachment.new
    render 'courses/show'
  end
  
  # Currently never called
  def create
    @assignment = Assignment.find(params[:assignment_id])
    @assignment_attachment = @assignment.assignment_attachment.create(assignment_attachment_params)
    if @assignment_attachment.save
      flash[:sucess] = "Attachment has been added"
      render 'course/show'
    else
      render 'course/show'
    end
  end
  
  def destroy
    @assignment = Assignment.find(params[:assignment_id])
    @assignment_attachment = @assignment.assignment_attachments.find(params[:id])
    @assignment_attachment.destroy
  end
  
  private
  
    def assignment_attachment_params
      params.require(:assignment_attachment).permit(:attachment, :assignment_id)
    end
  
end
