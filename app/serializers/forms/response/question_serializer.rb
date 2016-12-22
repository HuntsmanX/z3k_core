class Forms::Response::QuestionSerializer < ApplicationSerializer
  attributes :content, :order_index, :section_id, :id, :section_is_successful

  belongs_to :section
  has_many   :fields

  def section_is_successful
    object.section.is_successful
  end
end
