class RoleSerializer < ApplicationSerializer
  attributes :id, :name, :permissions, :users_count

  has_many :permissions

  def users_count
    object.users.count
  end

end
