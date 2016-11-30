class Forms::Response::SectionSerializer < ApplicationSerializer
  attributes :uid, :title, :description, :time_limit, :required_score, :acceptable_score,
             :score_units, :order_index, :bonus_time, :id

  belongs_to :response
  has_many   :questions

  def uid
    object.uuid
  end

end
