class Forms::Test < ApplicationRecord
  self.table_name = "forms_tests"

  has_many :sections, class_name: "Forms::Test::Section", inverse_of: :test, dependent: :destroy

  validates :name, presence: true
end
