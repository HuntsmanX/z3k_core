class PermissionSerializer < ApplicationSerializer

  attributes :id, :role_id, :key, :allowed, :conditions, :label, :resource_name, :condition_options

  def label
    permission_schema.label
  end

  def resource_name
    permission_schema.resource_name
  end

  def condition_options
    permission_schema.conditions.map { |c| c.as_json['table'] }
  end

  private

  def permission_schema
    @schema ||= PermissionsSchema.new.permission_for(object.key)
  end

end
