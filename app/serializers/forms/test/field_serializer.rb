class Forms::Test::FieldSerializer < ActiveModel::Serializer
  attributes :content, :score, :autocheck, :question_id, :field_type, :block_key, :order_index, :forms_test_field_id, :forms_test_question_id

  belongs_to :question
  has_many :options

end
