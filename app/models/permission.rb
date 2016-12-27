class Permission < ApplicationRecord

  belongs_to :role

  delegate :label, :resource_name, :resource, :action, :order_index, to: :schema

  def condition_options
    schema.conditions
  end

  private

  def schema
    @schema ||= PermissionsSchema.instance.permission_for key
  end

end
