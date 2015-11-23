class AttachmentController < ApplicationController

  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy if @attachment.attachable.user_id == current_user.id
    redirect_to :back
  end

end
