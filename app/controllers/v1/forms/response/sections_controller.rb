class V1::Forms::Response::SectionsController < ApplicationController

	def edit
		respond_with Forms::Response::Section.includes({questions: [{fields: :options}]}).friendly.find(params[:id])
	end

	def update
		response_section = ::Forms::Response::Section.friendly.find(params[:uuid])
		response_section.update section_params
		show_next_section = ::Forms::ResponseSectionChecker.can_visit_next_section?(response_section)
		next_response_section = response_section.next_section
		response = show_next_section ? next_response_section : {}
		render json: response
	end

	def show
		response_section = Forms::Response::Section.friendly.find(params[:id])
		render json: response_section, include:  [questions: [fields: :options]]
	end

	def section_params
		params.require(:section).permit(:title, :time_limit, :uuid,
																		questions_attributes: [:id, :section_id, :content,
																													 fields_attributes: [:id, :field_type, :block_key,
																																							 :user_content, :score, :autocheck, options_attributes:
																																									 [:id, :content, :user_selected, :is_correct, :order_index]]])
	end

end
