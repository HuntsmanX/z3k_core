class Forms::Test::Section < ApplicationRecord

  belongs_to :test,      class_name: 'Forms::Test',           inverse_of: :sections, counter_cache: true
  has_many   :questions, class_name: 'Forms::Test::Question', inverse_of: :section,  dependent: :destroy

  has_many   :fields, through: :questions, class_name: 'Forms::Test::Field'

  enum required_score_unit:    [:points, :percent], _prefix: true
  enum acceptable_score_unit:  [:points, :percent], _prefix: true
  enum show_next_section:      [:show_next_depending_on_score, :show_next_regardless_of_score]

  validates :title,             presence: true
  validates :time_limit,        numericality: true
  validates :bonus_time,        numericality: true
  validates :questions_to_show, numericality: true
  validates :required_score,    numericality: true
  validates :acceptable_score,  numericality: true

  validate  :max_required_score

  def max_required_score
    return unless required_score_unit_percent? && required_score.to_i > 100
    errors.add :required_score, 'should be less than or equal to 100%'
  end

  def alerts
    alerts = []

    if questions.count.zero?
      alerts << 'This section has no questions'
    end

    if required_score > fields.sum(:score) && required_score_unit_points?
      alerts << 'Required score is larger than max score'
    end

    if acceptable_score > fields.autocheck.sum(:score) && acceptable_score_unit_points?
      alerts << 'Acceptable autoscore is larger than max autoscore'
    end

    alerts
  end
  
end
