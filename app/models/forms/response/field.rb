class Forms::Response::Field < ApplicationRecord

  belongs_to :question, class_name: 'Forms::Response::Question', inverse_of: :fields
  has_many   :options,  class_name: 'Forms::Response::Option',   inverse_of: :field,  dependent: :destroy
	has_one 	 :section, through: :question,  class_name: 'Forms::Response::Section'

	delegate :response, to: :section, allow_nil: true

	after_save    :recalculate_scores, :recalculate_checked, :recalculate_successful
	after_destroy :recalculate_scores, :recalculate_checked, :recalculate_successful

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
    response&.recalculate_scores!
	end

  def recalculate_checked
	  response&.recalculate_checked!
  end

  def recalculate_successful
    section&.recalculate_successful!
  end

end
