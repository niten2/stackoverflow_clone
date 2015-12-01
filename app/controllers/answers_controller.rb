class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: [:destroy, :edit, :update, :make_best]
  before_action :set_question, only: [:new, :destroy, :edit, :update, :make_best]
  before_action :set_question_in_base, only: [:create]
  include Voted

  respond_to :js

  def make_best
    @answer.make_best if @question.user_id == current_user.id
  end

  def create
    respond_with( @answer = @question.answers.create(answer_params.merge(user: current_user)) )
  end

  def update
    @answer.update(answer_params) if current_user.autor_of?(@answer)
    respond_with @answer
  end

  def destroy
    respond_with(@answer.destroy) if current_user.autor_of?(@answer) || current_user.autor_of?(@question)
  end

  private

  def set_question_in_base
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def set_question
    @question = @answer.question
  end

  def answer_params
    params.require(:answer).permit(:content, attachments_attributes: [:file])
  end
end
