class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_owner_question, only: [:update, :edit, :destroy]
  before_action :set_question, only: [:show]
  before_action :build_answer, only: :show

  include Voted

  def index
    respond_with(@questions = Question.all)
  end

  def show
    respond_with @question
  end

  def new
    respond_with(@question = Question.new)
  end

  def edit
  end

  def create
    respond_with(@question = current_user.questions.create(question_params))
  end

  def update
    @question.update(question_params)
    respond_with @question
  end

  def destroy
    respond_with(@question.destroy) if current_user.autor_of?(@question)
  end

  private

  def build_answer
    @answer = @question.answers.build
  end

  def set_owner_question
    set_question
    unless current_user.autor_of?(@question)
      render text: 'У вас нет прав доступах', status: 403
    end
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :content, attachments_attributes: [:file, :_destroy, :id ])
  end

end
