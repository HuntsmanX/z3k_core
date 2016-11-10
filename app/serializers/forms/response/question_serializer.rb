class Forms::Response::QuestionSerializer < ActiveModel::Serializer
  attributes :content, :order_index, :section_id, :forms_test_section_id

  has_many :sections
  has_many :fields
end
