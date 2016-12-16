class PermissionSerializer < ApplicationSerializer

  attributes :id, :role_id, :key, :allowed, :conditions, :action, :elements, :schema

  def action
    Permission.get_schema[object.key][:action]
  end

  def elements
    Permission.get_schema[object.key][:elements]
  end

  def schema
    Permission.get_sorted_schema
  end
end
