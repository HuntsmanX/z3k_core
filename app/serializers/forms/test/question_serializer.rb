class Forms::Test::QuestionSerializer < ApplicationSerializer
  attributes :id, :content, :order_index, :section_id

  belongs_to :section
  has_many   :fields
end
