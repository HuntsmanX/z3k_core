class Forms::ResponseSerializer < ApplicationSerializer
  attributes :name, :created_at

  has_many :sections, if: :include_nested?

end
