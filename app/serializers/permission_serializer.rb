class PermissionSerializer < ApplicationSerializer

  attributes :id,
    :role_id,
    :key,
    :allowed,
    :conditions,
    :label,
    :resource_name,
    :condition_options,
    :order_index

end
