class AttachmentsController < ApplicationController
  before_action :set_attachment, only: :destroy

  def destroy
    @attachment.destroy if current_user.autor_of?(@attachment.attachable)
    redirect_to :back
  end

  private

  def set_attachment
    @attachment = Attachment.find(params[:id])
  end

end
