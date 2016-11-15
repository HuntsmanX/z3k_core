class Forms::Test::FieldSerializer < ApplicationSerializer
  attributes :content, :score, :autocheck, :question_id, :field_type, :block_key

  belongs_to :question
  has_many   :options
end
