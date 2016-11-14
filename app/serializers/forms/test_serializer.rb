class Forms::TestSerializer < ApplicationSerializer
  has_many :sections, if: :include_nested?

  attributes :id, :name
end
