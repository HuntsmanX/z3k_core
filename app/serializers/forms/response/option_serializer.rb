class Forms::Response::OptionSerializer < ApplicationSerializer
  attributes :content, :is_correct, :field_id, :order_index, :user_selected

  belongs_to :field
end
