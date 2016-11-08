class Forms::Test::Option < ApplicationRecord
  belongs_to :field, class_name: 'Forms::Test::Field', inverse_of: :options

  default_scope -> { order(:order_index) }
end
