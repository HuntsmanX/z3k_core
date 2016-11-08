class Forms::Response::Option < ApplicationRecord
  belongs_to :field, class_name: 'Forms::Response::Field', inverse_of: :options
end
