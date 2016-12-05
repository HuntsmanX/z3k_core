class Forms::Response::FieldSerializer < ApplicationSerializer
  attributes :content, :score, :autocheck, :question_id, :field_type, :block_key, :user_content, :user_score, :checked, :id

  has_many   :options
end
