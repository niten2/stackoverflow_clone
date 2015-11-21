class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.build
  end

  def new
    @question = Question.new
    @question.attachments.build
  end

  def edit
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      redirect_to @question, notice:'Вопрос создан'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question, notice: "Вопрос изменен"
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: "Вопрос удален"
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :content, attachments_attributes: [:file])
  end
end
