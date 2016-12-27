class Forms::Response < ApplicationRecord
  include TestConcern
  self.table_name = "forms_responses"

  belongs_to :user
  has_many   :sections,  class_name: 'Forms::Response::Section', inverse_of: :response, dependent: :destroy

  has_many :questions, through: :sections,  class_name: 'Forms::Response::Question'
  has_many :fields,    through: :questions, class_name: 'Forms::Response::Field'

  validates :name,    presence: true
  validates :user_id, presence: true

  default_scope -> { order('created_at DESC') }

  def is_successful
    if successful_sections?
      successful_by_sections_count?
    elsif total_score?
      successful_by_total_score?
    end
  end

  def recalculate_scores!
    max_score = fields.sum(:score)
    user_score = fields.sum(:user_score)
    update_attributes(max_score: max_score, user_score: user_score) if max_score && user_score
  end

  def recalculate_checked!
    update_attributes checked: fields.pluck(:checked).all?
  end

  private

  def successful_by_sections_count?
    sections.select { |s| s.is_successful? }.count >= self.successful_sections_count
  end

  def successful_by_total_score?
    score_sum = self.fields.map(&:user_score).sum

    if self.points?
      score_sum >= self.required_score
    elsif self.percent?
      (score_sum * required_score / 100) >= self.required_score
    end

  end

end
