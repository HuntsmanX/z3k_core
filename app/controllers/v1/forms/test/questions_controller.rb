class V1::Forms::Test::QuestionsController < ApplicationController

  def create
    question = Test::Question.new question_params
    question.save
    respond_with question
  end

  def update
    question = Test::Question.find params[:id]
    question.update_attributes question_params
    respond_with question
  end

  def destroy
    question = Test::Question.find params[:id]
    question.destroy
    render json: {}
  end

  private

  def question_params
    params.require(:question).permit(
      :section_id, :content,
      fields_attributes: [
        :id, :field_type, :block_key, :content, :score, :autocheck, :_destroy,
        options_attributes: [
          :id, :content, :is_correct, :_destroy
        ]
      ]
    )
  end

end
