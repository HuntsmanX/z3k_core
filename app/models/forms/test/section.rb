class Forms::Test::Section < ApplicationRecord
  self.table_name = "forms_test_sections"

  belongs_to :test, class_name: "Forms::Test", inverse_of: :sections
end
