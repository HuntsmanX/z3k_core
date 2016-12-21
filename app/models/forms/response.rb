class Forms::Response < ApplicationRecord
  include TestConcern
  self.table_name = "forms_responses"
  
  has_many :sections, class_name: 'Forms::Response::Section', inverse_of: :response, dependent: :destroy
  has_many :fields,    through: :sections, class_name: 'Forms::Response::Field'
  has_many :questions, through: :sections, class_name: 'Forms::Response::Question'
  belongs_to :user

  validates :name,    presence: true
  validates :user_id, presence: true

  default_scope -> { order('created_at DESC') }

  def successful?
    self&.sections&.pluck(:is_successful).uniq.include?(false || nil) ? false : true
  end

end
