class Forms::Test::SectionSerializer < ApplicationSerializer
  belongs_to :test
  has_many   :questions

  attributes :id,
             :test_id,
             :title,
             :description,
             :time_limit,
             :bonus_time,
             :required_score,
             :required_score_units,
             :acceptable_score,
             :acceptable_score_units,
             :order_index,
             :shuffle_questions,
             :questions_to_show,
             :show_next_section
end
