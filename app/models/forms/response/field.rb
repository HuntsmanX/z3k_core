class Forms::Response::Field < ApplicationRecord
  belongs_to :question, class_name: 'Forms::Response::Question', inverse_of: :fields
  has_many   :options,  class_name: 'Forms::Response::Option',   inverse_of: :field,  dependent: :destroy
	has_one 	 :section, through: :question,  class_name: 'Forms::Response::Section'

	delegate :response, to: :section, allow_nil: true

	after_save :recalculate_scores
	after_destroy :recalculate_scores

  after_save :set_response_checked
  after_destroy :set_response_checked

  after_save :set_section_successful
  after_destroy :set_section_successful

  enum field_type: [
   :text_input,
   :text_area,
   :dropdown,
	 :checkboxes,
	 :radio_buttons,
	 :sequence,
	 :text_editor,
   :inline_text_input,
   :inline_dropdown
	]

  accepts_nested_attributes_for :options, allow_destroy: true

	private

	def recalculate_scores
		max_score =  response&.fields&.sum('score')
		user_score = response&.fields&.sum('user_score')
		response&.update_attributes(max_score: max_score, user_score: user_score) if max_score && user_score
	end

  def set_response_checked
	   if (response&.fields.pluck(:checked).uniq.include? false)
		   response&.update_attributes(checked: false)
	   else
		   response&.update_attributes(checked: true)
	   end
  end

	def set_section_successful
		user_score = self.section&.fields&.sum('user_score')
	  if self.section.required_score_unit_percent?
			self.section&.update_attributes(is_successful: user_score >= count_ratio)
	  else
		  self.section&.update_attributes(is_successful: user_score >= self.section.required_score)
	  end
	end

	def count_ratio
		max_score = self.section&.fields&.sum('score')
		max_score * self.section.required_score / 100
	end

end
