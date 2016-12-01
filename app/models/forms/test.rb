class Forms::Test < ApplicationRecord
  include TestConcern
  self.table_name = "forms_tests"

  has_many :sections, class_name: "Forms::Test::Section", inverse_of: :test, dependent: :destroy

  validates :name, presence: true

  def self.search_by_name(pattern)
    where('name ILIKE ?', "%#{pattern}%")
  end
end
