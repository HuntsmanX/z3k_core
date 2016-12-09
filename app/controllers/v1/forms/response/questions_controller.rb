class V1::Forms::Response::QuestionsController < ApplicationController
  before_action :authenticate_v1_user!
  respond_to :json

  def update
    question = ::Forms::Response::Question.find params[:id]
    if question.update_attributes question_params
      render json: question, include: [fields: :options]
    else
      render json: question.errors.messages, status: 422
    end
  end


  private

  def question_params
    parameters = params.require(:question).permit(
      :section_id,
      fields_attributes: [
        :id,
        :user_score,
        :user_content,
        :checked
      ]
    )
  end
end
