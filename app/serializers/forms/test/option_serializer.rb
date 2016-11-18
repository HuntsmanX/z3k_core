class Forms::Test::OptionSerializer < ApplicationSerializer
  attributes :id, :content, :is_correct, :field_id, :order_index

  belongs_to :field
end
