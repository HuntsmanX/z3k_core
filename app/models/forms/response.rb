class Forms::Response < ApplicationRecord
  include TestConcern
  self.table_name = "forms_responses"

  belongs_to :user
  has_many   :sections,  class_name: 'Forms::Response::Section', inverse_of: :response, dependent: :destroy

  has_many :questions, through: :sections,  class_name: 'Forms::Response::Question'
  has_many :fields,    through: :questions, class_name: 'Forms::Response::Field'

  validates :name,    presence: true
  validates :user_id, presence: true

  default_scope -> { order('created_at DESC') }

  # TODO Update this when corresponding settings have been added to Forms::Test
  def is_successful
    sections.map(&:is_successful).all?
	end

  def recalculate_scores!
    max_score  = fields.sum(:score)
		user_score = fields.sum(:user_score)
		update_attributes(max_score: max_score, user_score: user_score) if max_score && user_score
  end

  def recalculate_checked!
    update_attributes checked: fields.pluck(:checked).all?
  end

end
