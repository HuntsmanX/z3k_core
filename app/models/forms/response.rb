class Forms::Response < ApplicationRecord
  include ConcernSerializer
  self.table_name = "forms_responses"
  has_many   :sections, class_name: 'Forms::Response::Section', inverse_of: :response, dependent: :destroy
  belongs_to :user

  validates :name, presence: true

end
