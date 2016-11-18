class Forms::Test::QuestionSerializer < ApplicationSerializer
  attributes :id, :content, :order_index, :section_id

  belongs_to :sections
  has_many   :fields
end
