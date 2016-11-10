class Forms::Response::SectionSerializer < ActiveModel::Serializer
  attributes :title, :description, :time_limit, :required_score, :uuid, :acceptable_score,
             :score_units, :order_index

  belongs_to :response
  has_many :questions

end
