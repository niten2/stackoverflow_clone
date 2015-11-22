class AttachmentController < ApplicationController

  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy
    redirect_to :back
  end

end
