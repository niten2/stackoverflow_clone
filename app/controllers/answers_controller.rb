class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: [:destroy, :edit, :update, :make_best]
  before_action :set_question, only: [:new, :destroy, :edit, :update, :make_best]
  include Voted

  def make_best
    @answer.make_best if @question.user_id == current_user.id
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def update
    @answer.update(answer_params)
  end

  def destroy
    @answer.destroy
  end

  private

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
