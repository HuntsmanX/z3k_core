class V1::Forms::Response::SectionsController < ApplicationController

	def update
		response_section = ::Forms::Response::Section.friendly.find(params[:id])
		response_section.update section_params
		show_next_section = ::Forms::CheckResponseSection.can_visit_next_section?(response_section)
		next_response_section = response_section.next_section
		response = show_next_section ? next_response_section : {}
		render json: response, include: [sections: [fields: :options]], testee: true
	end

	def show
		response_section = ::Forms::Response::Section.friendly.find(params[:id])
		render json: response_section, include: [questions: [fields: :options]], testee: true
	end

	def section_params
		params.require(:section).permit(
      :title,
      :time_limit,
      :bonus_time,
      :uuid,
			questions_attributes: [
        :id,
        :section_id,
        :content,
				fields_attributes: [
          :id,
          :field_type,
          :block_key,
          :user_content,
          :score,
          :autocheck,
          options_attributes: [
            :id,
            :content,
            :user_selected,
            :is_correct,
            :order_index
          ]
        ]
      ]
    )
	end

end
