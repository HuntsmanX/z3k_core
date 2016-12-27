class UserSerializer < ApplicationSerializer
  attributes :id, :email, :full_name_eng, :role_ids

  has_many :roles
end
