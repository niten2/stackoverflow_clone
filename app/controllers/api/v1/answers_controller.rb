class Api::V1::AnswersController < Api::V1::BaseController
  authorize_resource class: Answer
  before_action :set_question, only: [:index]

  def index
    respond_with @question.answers, each_serializer: AnswerCollectionSerializer
  end

  def show
  end


private

  def set_question
    @question = Question.find(params[:question_id])
  end

end



