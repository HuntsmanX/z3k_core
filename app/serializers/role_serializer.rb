class RoleSerializer < ApplicationSerializer
  attributes :id, :name, :permissions

  has_many :permissions
end
