class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_commentable, only: :create

  def create

    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    @comment.save

    # redirect_to :back
    # if @comment.save
      # PrivatePub.publish_to "/questions/#{@commentable.try(:question).try(:id) || @commentable.id}/comments", comment: render_to_string(template: 'comments/show')
      # render nothing: true
    # else
    #   render json: @comment.errors.full_messages, status: :unprocessable_entity
    # end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy if current_user.autor_of?(@comment.commentable) || current_user.autor_of?(@comment)
    redirect_to :back
  end

  private

  def set_commentable
    # binding.pry
    # @commentable = commentable_name.find(params[commentable_id])
    params.each do |name, value|
      if name =~ /(.+)_id$/
        @commentable_name = $1
        @commentable = $1.classify.constantize.find(value)
      end
    end

  end

  # def commentable_id
  #   (params[:commentable].singularize + '_id').to_sym
  # end

  # def commentable_name
  #   params[:commentable].classify.constantize
  # end

  def comment_params
    params.require(:comment).permit(:content)
  end

end

