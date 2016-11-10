class Forms::Test::OptionSerializer < ActiveModel::Serializer
  attributes :content, :is_correct, :field_id, :order_index, :forms_test_field_id

  belongs_to :field

end
