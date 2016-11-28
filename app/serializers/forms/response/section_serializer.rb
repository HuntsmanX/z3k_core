class Forms::Response::SectionSerializer < ApplicationSerializer
  attributes :title, :description, :time_limit, :required_score, :uuid, :acceptable_score,
             :score_units, :order_index, :bonus_time

  belongs_to :response
  has_many   :questions
end
