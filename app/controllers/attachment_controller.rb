class AttachmentController < ApplicationController

  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy if current_user.autor_of?(@attachment)
    redirect_to :back
  end

end
