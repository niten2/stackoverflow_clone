class Api::V1::AnswersController < Api::V1::BaseController

  authorize_resource class: Answer
  before_action :set_question, only: [:index, :show, :create]

  def index
    respond_with @question.answers, each_serializer: AnswerCollectionSerializer
  end

  def show
    respond_with @question.answers.find(params[:id])
  end

  def create
    respond_with @question.answers.create(answer_params.merge(user: current_resource_owner))
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:content)
  end

end
