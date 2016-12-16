class Forms::Response::OptionSerializer < ApplicationSerializer
  attributes :field_id, :order_index, :user_selected, :id, :content, :correct_order_index

  attribute :is_correct, unless: :testee?
end
