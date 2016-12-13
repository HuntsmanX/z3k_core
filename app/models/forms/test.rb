class Forms::Test < ApplicationRecord
  include TestConcern
  self.table_name = 'forms_tests'

  has_many :sections, class_name: 'Forms::Test::Section', inverse_of: :test, dependent: :destroy
  has_many :fields, through: :sections, class_name: 'Forms::Test::Field'

  validates :name, presence: true

  def self.search_by_name(pattern)
    where('name ILIKE ?', "%#{pattern}%")
  end

  def alerts
    alerts = []

    if sections.blank?
      alerts << 'This test has no sections'
    end

    if sections.any? { |s| s.alerts.present? }
      alerts << 'This test has sections with warnings'
    end

    alerts
  end

end
