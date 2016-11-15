class Forms::Test::QuestionSerializer < ApplicationSerializer
  attributes :content, :order_index, :section_id

  belongs_to :sections
  has_many   :fields
end
