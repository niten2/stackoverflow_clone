class AttachmentsController < ApplicationController
  before_action :set_attachment, only: :destroy
  authorize_resource

  def destroy
    @attachment.destroy
    redirect_to :back
  end

  private

  def set_attachment
    @attachment = Attachment.find(params[:id])
  end

end
