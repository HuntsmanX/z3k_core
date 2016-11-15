class Forms::Test::QuestionSerializer < ApplicationSerializer
  attributes :content, :order_index

  belongs_to :sections
  has_many   :fields
end
