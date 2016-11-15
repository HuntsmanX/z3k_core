class Forms::Response::QuestionSerializer < ApplicationSerializer
  attributes :content, :order_index, :section_id, :forms_test_section_id

  belongs_to :section
  has_many   :fields
end
