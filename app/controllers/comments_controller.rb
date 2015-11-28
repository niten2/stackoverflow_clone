class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]


  def create
    # binding.pry

  end

  def destroy
    redirect_to :back
    # @attachment = Attachment.find(params[:id])
    # @attachment.destroy if current_user.autor_of?(@attachment.attachable)
    # redirect_to :back
  end

  # def question_params
  #   params.require(:comment_attributes).permit(:content, :_destroy, :id ])
  # end

end

