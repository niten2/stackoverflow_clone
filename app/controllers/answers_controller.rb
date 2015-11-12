class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]
  before_action :set_question, only: [:create, :new, :destroy, :edit, :update]
  before_action :set_answer, only: [:destroy, :edit, :update]

  def new
    @answer = Answer.new
  end

  def edit
  end

  def create
    @answer = current_user.answer.new(answer_params)
    @question.answers << @answer
    if @answer.save
      flash[:notice] = "Вы ответили"
      redirect_to @question
    else
      render :new
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to @question
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
