class Forms::Test::QuestionSerializer < ApplicationSerializer

  attributes :id, :content, :order_index, :section_id

  has_many :fields

end
