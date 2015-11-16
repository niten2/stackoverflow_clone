class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:create, :new, :destroy, :edit, :update]
  before_action :set_answer, only: [:destroy, :edit, :update]

  def new
    @answer = Answer.new
  end

  def edit
  end

  def make_best
    @question = @answer.question
    @answer.make_best if @question.user_id == current_user.id
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def update
    @answer.update(answer_params)
    @question = @answer.question
  end

  def destroy
    @answer.destroy
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:content)
  end
end
