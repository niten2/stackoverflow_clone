class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_commentable, only: :create
  before_action :set_comment, only: :destroy
  respond_to :js
  authorize_resource

  def create
    respond_with(@comment = @commentable.comments.create(comment_params.merge(user: current_user)))
  end

  def destroy
    @comment.destroy
    redirect_to :back
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        @commentable_name = $1
        @commentable = $1.classify.constantize.find(value)
      end
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end

