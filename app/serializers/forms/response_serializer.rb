class Forms::ResponseSerializer < ActiveModel::Serializer
  attributes :name, :created_at

  has_many :sections

end
