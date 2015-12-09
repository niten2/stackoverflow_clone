class Api::V1::QuestionsController < Api::V1::BaseController
  authorize_resource class: Question

  def index
    @questions = Question.all
    # respond_with @questions.to_json( include: :answers)
    respond_with @questions
  end

end
