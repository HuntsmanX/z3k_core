class Forms::TestSerializer < ApplicationSerializer
  has_many :sections

  attributes :id, :name
end
