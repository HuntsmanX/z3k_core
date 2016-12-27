class UserPolicy < ApplicationPolicy

  def index?
    allowed? 'staff:user:view'
  end

  def update?
    allowed? 'staff:user:update'
  end

end
