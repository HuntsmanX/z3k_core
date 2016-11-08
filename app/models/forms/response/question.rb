class Forms::Response::Question < ApplicationRecord
  belongs_to :section, class_name: 'Forms::Response::Section', inverse_of: :questions
  has_many   :fields,  class_name: 'Forms::Response::Field',   inverse_of: :question,  dependent: :destroy

  accepts_nested_attributes_for :fields, allow_destroy: true

  default_scope -> { order(:order_index) }
end
