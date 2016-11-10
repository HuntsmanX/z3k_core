class Forms::Test::SectionSerializer < ActiveModel::Serializer
  attributes :title, :description, :time_limit, :bonus_time, :required_score, :required_score_units, :acceptable_score,
             :acceptable_score_units, :order_index, :shuffle_questions, :questions_to_show, :show_next_section

  belongs_to :test
  has_many :questions

end
