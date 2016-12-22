class Forms::Test < ApplicationRecord
  include TestConcern
  self.table_name = 'forms_tests'

  has_many :sections, class_name: 'Forms::Test::Section', inverse_of: :test, dependent: :destroy
  has_many :fields, through: :sections, class_name: 'Forms::Test::Field'

  validates :name, presence: true

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

  def recalculate_max_score!
    max_score = fields.sum(:score)
    update_attributes(max_score: max_score) if max_score
  end

end
