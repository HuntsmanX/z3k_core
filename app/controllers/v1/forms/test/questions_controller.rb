class V1::Forms::Test::QuestionsController < ApplicationController
  before_action :authenticate_v1_user!

  def create
    authorize ::Forms::Test::Question
    question = ::Forms::Test::Question.new question_params
    if question.save
      render json: question, include: [fields: :options]
    else
      render json: question.errors.messages, status: 422
    end
  end

  def update
    question = ::Forms::Test::Question.find params[:id]
    authorize question
    if question.update_attributes question_params
      render json: question, include: [fields: :options]
    else
      render json: question.errors.messages, status: 422
    end
  end

  def destroy
    question = ::Forms::Test::Question.find params[:id]
    authorize question
    question.destroy
    render json: {}
  end

  def reorder
    authorize ::Forms::Test::Question
    params[:order].each do |id, index|
      ::Forms::Test::Question.find(id).update_attribute :order_index, index
    end
    render json: {}
  end

  private

  def question_params
    params.require(:question).permit(
      :section_id,
      :content,
      :order_index,
      fields_attributes: [
        :id,
        :field_type,
        :block_key,
        :content,
        :score,
        :autocheck,
        :_destroy,
        options_attributes: [
          :id,
          :content,
          :is_correct,
          :order_index,
          :_destroy
        ]
      ]
    )
  end

end
