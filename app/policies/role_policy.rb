class RolePolicy < ApplicationPolicy

  def index?
    allowed? 'staff:role:view'
  end

  def create?
    allowed? 'staff:role:update'
  end

  def show?
    allowed? 'staff:role:view'
  end

  def update?
    allowed? 'staff:role:update'
  end

  def find?
    allowed? 'staff:user:view'
  end

end
