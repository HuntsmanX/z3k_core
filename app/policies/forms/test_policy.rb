class Forms::TestPolicy < ApplicationPolicy

  def index?
    allowed? 'forms:test:view'
  end

  def find?
    allowed? 'forms:response:create'
  end

  def create?
    allowed? 'forms:test:update'
  end

  def show?
    allowed? 'forms:test:view'
  end

  def update?
    allowed? 'forms:test:update'
  end

  def update?
    allowed?(:test, :update)
  end

  def destroy?
    allowed? 'forms:test:delete'
  end

end
