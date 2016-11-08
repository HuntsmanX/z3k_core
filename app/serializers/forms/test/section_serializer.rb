class Forms::Test::SectionSerializer < ActiveModel::Serializer
  attributes :title

  belongs_to :test, serializer: Forms::TestSerializer
end
