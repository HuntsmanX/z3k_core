class Forms::Test::SectionSerializer < ApplicationSerializer

  attributes :id,
    :test_id,
    :title,
    :description,
    :time_limit,
    :bonus_time,
    :required_score,
    :required_score_unit,
    :acceptable_score,
    :acceptable_score_unit,
    :order_index,
    :shuffle_questions,
    :questions_to_show,
    :show_next_section,
    :alerts

  has_many :questions, if: :include_nested?

  def alerts
    alerts = []

    if object.required_score > object.fields.sum(:score) && object.required_score_unit_points?
      alerts << 'Required score is larger than max score'
    end

    if object.acceptable_score > object.fields.autocheck.sum(:score) && object.acceptable_score_unit_points?
      alerts << 'Acceptable autoscore is larger than max autoscore'
    end

    alerts
  end

end
