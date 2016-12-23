class Forms::Test < ApplicationRecord
  include TestConcern
  self.table_name = 'forms_tests'

  has_many :sections, class_name: 'Forms::Test::Section', inverse_of: :test, dependent: :destroy
  has_many :fields, through: :sections, class_name: 'Forms::Test::Field'

  enum success_criterion: [:total_score, :successful_sections]
  enum required_score_unit: [:points, :percent]

  validates :name, presence: true
  validate :required_score_less_than_max, if: :total_score?
  validate :percentage_less_than_100, if: :total_score?

  def alerts
    alerts = []

    if sections.blank?
      alerts << 'This test has no sections'
    end

    if sections.any? { |s| s.alerts.present? }
      alerts << 'This test has sections with warnings'
    end

    if self.successful_sections? && (sections.count <= self.successful_sections_count)
      alerts << "'Successful sections count' should be less than or equals to total sections count"
    end

    alerts
  end

  def recalculate_max_score!
    max_score = fields.sum(:score)
    update_attributes(max_score: max_score) if max_score
  end

  private

  def required_score_less_than_max
    if self.points?
      is_valid = self.required_score <= self.max_score
      errors.add(:required_score, 'should be less than or equals to max score') unless is_valid
    end
  end

  def percentage_less_than_100
    if self.percent?
      is_valid = (0..100).cover?(self.required_score)
      errors.add(:percentage, 'should be between 0% and 100%') unless is_valid
    end
  end

end
