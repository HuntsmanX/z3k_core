class ApplicationSerializer < ActiveModel::Serializer
  type :data

  def include_nested?
    @instance_options[:with_nested] || !@instance_options.key?(:with_nested)
  end
end
