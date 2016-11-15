class V1::Forms::Test::SectionsController < ApplicationController

  def create
    section = ::Forms::Test::Section.new section_params
    if section.save
      render json: section
    else
      render json: section.errors.messages, status: 422
    end
  end

  def update
    section = ::Forms::Test::Section.find_by_id params[:id]

    if section.update_attributes section_params
      render json: section
    else
      render json: section.errors.messages, status: 422
    end

  end

  def destroy
    section = ::Forms::Test::Section.find_by_id params[:id]
    section.destroy
    render json: {}
  end

  private

  def section_params
    params.require(:section).permit(:title, :description, :time_limit, :required_score, :test_id)
  end

end
