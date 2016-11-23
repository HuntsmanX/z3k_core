class Forms::Test::Option < ApplicationRecord
  belongs_to :field, class_name: 'Forms::Test::Field', inverse_of: :options
end
