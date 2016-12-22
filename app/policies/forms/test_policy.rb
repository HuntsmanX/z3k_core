class Forms::TestPolicy < ApplicationPolicy

  def index?
    allowed?(:test, :index)
  end

  def create?
    allowed?(:test, :create)
  end

  def show?
    allowed?(:test, :show)
  end

  def edit?
    allowed?(:test, :edit)
  end

  def destroy?
    allowed?(:test, :delete)
  end

end