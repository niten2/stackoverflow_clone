class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy if current_user.autor_of?(@comment.commentable)
    redirect_to :back
  end

end

