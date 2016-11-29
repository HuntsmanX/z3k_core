class V1::Forms::Response::QuestionsController < ApplicationController

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
    params.require(:question).permit(
        :section_id,
        fields_attributes: [
            :id,
            :user_score,
        ]
    )
  end
end
