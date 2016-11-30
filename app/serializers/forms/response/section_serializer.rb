class Forms::Response::SectionSerializer < ApplicationSerializer
  attributes :uid, :title, :description, :time_limit, :required_score, :acceptable_score,
             :order_index, :bonus_time, :id, :acceptable_score_units, :required_score_units

  belongs_to :response
  has_many   :questions

  def uid
    object.uuid
  end

end
