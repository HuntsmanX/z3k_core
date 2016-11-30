class Forms::Response::OptionSerializer < ApplicationSerializer
  attributes :field_id, :order_index, :user_selected, :id
  attribute :content, unless: :testee?
  attribute :is_correct, unless: :testee?

  belongs_to :field
end
