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
    # respond_to do |format|
    #   if @answer.save
    #     format.js do
    #       PrivatePub.publish_to "/questions/#{@question.id}/answers", answer: @answer.to_json
    #       render nothing: true
    #     end
    #   else
    #     format.json { render json: @answer.errors.full_messages, status: :unprocessable_entity }
    #     format.js
    #   end
    # end
  end


  def update
    @answer.update(answer_params)
  end

  def destroy
    @answer.destroy if current_user.autor_of?(@answer) || current_user.autor_of?(@question)
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
