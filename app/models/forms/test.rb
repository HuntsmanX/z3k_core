class Forms::Test < ApplicationRecord
  include TestConcern
  self.table_name = 'forms_tests'

  has_many :sections, class_name: 'Forms::Test::Section', inverse_of: :test, dependent: :destroy
  has_many :fields, through: :sections, class_name: 'Forms::Test::Field'

  validates :name, presence: true

  validates :required_score,            presence: true, numericality: true, if: :total_score?
  validates :successful_sections_count, presence: true, numericality: true, if: :successful_sections?

  validate  :percentage_less_than_100, if: :total_score?

  def alerts
    alerts = []

    if sections.blank?
      alerts << 'This test has no sections'
    end

    if sections.any? { |s| s.alerts.present? }
      alerts << 'This test has sections with warnings'
    end

    if self.successful_sections? && (sections.count <= self.successful_sections_count)
      alerts << "Successful sections count is larger than total sections count"
    end

    if self.total_score? && self.points? && self.required_score > self.max_score
      alerts << "Required score is larger than max score"
    end

    alerts
  end

  def recalculate_max_score!
    max_score = fields.sum(:score)
    update_attributes(max_score: max_score) if max_score
  end

  private

  def percentage_less_than_100
    if self.total_score? && self.percent?
      is_valid = (0..100).cover?(self.required_score)
      errors.add(:percentage, 'should be less than or equal to 100%') unless is_valid
    end
  end

end
