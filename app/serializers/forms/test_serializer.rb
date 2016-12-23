class Forms::TestSerializer < ApplicationSerializer
  attributes :id,
    :name,
    :sections_count,
    :questions_count,
    :max_score,
    :shuffle_questions,
    :time_limit,
    :alerts,
    :success_criterion,
    :required_score,
    :required_score_unit,
    :successful_sections_count

  has_many :sections, if: :include_nested?
end
