class Forms::Response::Option < ApplicationRecord
  belongs_to :field, class_name: 'Forms::Response::Field', inverse_of: :options

  default_scope -> { order(:order_index) }
end
