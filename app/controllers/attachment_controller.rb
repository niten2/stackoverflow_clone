class AttachmentController < ApplicationController

  def destroy
    # binding.pry
    # @question = Question.find(params[:question_id])
    # @answer = Question.find(params[:answer_id])

    @attachment = Attachment.find(params[:id])
    @attachment.destroy if @attachment.attachable.user_id == current_user.id
    redirect_to :back
  end

end
