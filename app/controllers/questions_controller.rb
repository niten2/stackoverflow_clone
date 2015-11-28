class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_owner_question, only: [:update, :edit, :destroy]
  before_action :set_question, only: [:show]
  include Voted

  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.build
    gon.questionId = @question.id
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      PrivatePub.publish_to "/questions", question: @question.to_json, current_user: current_user.to_json, user: @question.user.to_json
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
    @question.destroy if current_user.autor_of?(@question)
    redirect_to questions_path, notice: "Вопрос удален"
  end

  private

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
    params.require(:question).permit(:title, :content, attachments_attributes: [:file, :_destroy, :id ], comments_attributes: [:content, :_destroy, :id])
  end

end
