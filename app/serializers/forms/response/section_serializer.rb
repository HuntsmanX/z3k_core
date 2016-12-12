class Forms::Response::SectionSerializer < ApplicationSerializer
  attributes :uid, :title, :description, :time_limit, :required_score, :acceptable_score,
             :order_index, :bonus_time, :id, :acceptable_score_unit, :required_score_unit,
             :user_score, :is_passed

  has_many   :questions, if: :include_nested?

  def uid
    object.uuid
  end

  def user_score
    object&.fields&.sum('user_score')
  end

  def is_passed
    user_scores >= object.required_score ? 'Yes' : 'No'
  end

end
