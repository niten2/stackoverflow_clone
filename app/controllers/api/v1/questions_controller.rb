class Api::V1::QuestionsController < Api::V1::BaseController

  authorize_resource class: Question

  def index
    respond_with Question.all, each_serializer: QuestionCollectionSerializer
  end

  def show
    respond_with Question.find(params[:id])
  end

  def create
    respond_with current_resource_owner.questions.create(question_params)
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end

end
