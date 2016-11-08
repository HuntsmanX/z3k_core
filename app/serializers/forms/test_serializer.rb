class Forms::TestSerializer < ActiveModel::Serializer
  attributes :name, :created_at

  has_many :sections, serializer: Forms::Test::SectionSerializer
end
