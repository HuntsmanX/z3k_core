class V1::Forms::Test::SectionsController < ApplicationController

  def create
    section = ::Forms::Test::Section.new section_params
    if section.save
      render json: section, include: [questions: [fields: :options]]
    else
      render json: section.errors.messages, status: 422
    end
  end

  def update
    section = ::Forms::Test::Section.find_by_id params[:id]

    if section.update_attributes section_params
      render json: section, include: [questions: [fields: :options]]
    else
      render json: section.errors.messages, status: 422
    end
  end

  def destroy
    section = ::Forms::Test::Section.find_by_id params[:id]
    section.destroy
    render json: {}
  end

  def reorder
    params[:order].each do |id, index|
      ::Forms::Test::Section.find(id).update_attribute :order_index, index
    end
    render json: {}
  end

  private

  def section_params
    params.require(:section).permit(
      :test_id,
      :title,
      :description,
      :time_limit,
      :bonus_time,
      :required_score,
      :required_score_units,
      :acceptable_score,
      :acceptable_score_units,
      :order_index,
      :shuffle_questions,
      :questions_to_show,
      :show_next_section
    )
  end

end
