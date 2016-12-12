class Forms::Response::SectionSerializer < ApplicationSerializer
  attributes :uid, :title, :description, :time_limit, :required_score, :acceptable_score,
             :order_index, :bonus_time, :id, :acceptable_score_unit, :required_score_unit

  has_many   :questions, if: :include_nested?

  def uid
    object.uuid
  end

end
