class Forms::Response::QuestionSerializer < ApplicationSerializer
  attributes :content, :order_index, :section_id

  belongs_to :section
  has_many   :fields
end
