class Forms::TestSerializer < ApplicationSerializer
  attributes :id,
    :name,
    :sections_count,
    :questions_count,
    :max_score,
    :shuffle_questions,
    :time_limit,
    :alerts

  has_many :sections, if: :include_nested?
end
