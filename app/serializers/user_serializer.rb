class UserSerializer < ApplicationSerializer
  attributes :id, :email, :full_name_eng

  def full_name_eng
    object.full_name
  end
end
