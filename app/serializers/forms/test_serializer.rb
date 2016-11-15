class Forms::TestSerializer < ApplicationSerializer
  attributes :id, :name

  has_many :sections, if: :include_nested?
end
