class UserSerializer < ApplicationSerializer
  attributes :id, :email, :full_name_eng, :permissions

  has_many :roles

  def permissions
    permissions = Hash[object.permissions.group_by { |d| d[:key] }.map{|k, v| [k, v.any?{|a| a.allowed?}] }]
    permissions.map{|p| {key: p[0], allowed: p[1], label: permission_schema_for(p[0]).label}}
  end

  private

  def permission_schema_for(key)
    PermissionsSchema.new.permission_for(key)
  end

end
