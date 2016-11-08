class Forms::Response < ApplicationRecord
  has_many   :sections, class_name: 'Forms::Response::Section', inverse_of: :response, dependent: :destroy
  belongs_to :testee

  validates :name, presence: true
end
