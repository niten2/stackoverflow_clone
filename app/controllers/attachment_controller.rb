class AttachmentController < ApplicationController

  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy if current_user.autor_of?(@attachment.attachable)
    redirect_to :back
  end

end
