class V1::Forms::Response::SectionsController < ApplicationController
  respond_to :json

#TODO: N+1 in finder
	def update
		section = ::Forms::Response::Section.friendly.find(params[:id])
		section.update_attributes section_params

		successful = ::Forms::CheckResponseSection.check(section)
		next_section = successful ? section.next_section : nil

		render json: section, with_nested: false, meta: { next_uid: next_section.try(:uuid) }
	end

	def show
		section = ::Forms::Response::Section.includes(questions: [fields: :options]).friendly.find(params[:id])
		render json: section, include: [questions: [fields: :options]], testee: true
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
            :order_index,
            :_destroy
          ]
        ]
      ]
    )
	end

end
