class Forms::Test::FieldSerializer < ApplicationSerializer

  attributes :id, :content, :score, :autocheck, :question_id, :field_type, :block_key

  has_many :options

end
