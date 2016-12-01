class Forms::Test < ApplicationRecord
  include TestConcern
  self.table_name = 'forms_tests'

  has_many :sections, class_name: 'Forms::Test::Section', inverse_of: :test, dependent: :destroy
  has_many :fields, through: :sections, class_name: 'Forms::Test::Field'

  validates :name, presence: true
end
