class Forms::ResponseSerializer < ApplicationSerializer
  attributes :id, :name, :created_at

  has_many :sections, if: :include_nested?

end
