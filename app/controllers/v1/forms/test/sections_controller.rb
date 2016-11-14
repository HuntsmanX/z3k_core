class V1::Forms::Test::SectionsController < ApplicationController

  def create
    section = Test::Section.new section_params
    section.save
    respond_with section
  end

  def update
    section = Test::Section.find_by_id params[:id]

    if section.update_attributes section_params
      render json: { id: section.id }
    else
      respond_with section
    end

  end

  def destroy
    section = Test::Section.find_by_id params[:id]
    section.destroy
    render json: {}
  end

  private

  def section_params
    params.require(:section).permit(:title, :description, :time_limit, :required_score, :test_id)
  end

end
