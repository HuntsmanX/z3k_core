class Forms::Test::SectionPolicy < ApplicationPolicy

  def create?
    allowed? 'forms:test:update'
  end

  def update?
    allowed? 'forms:test:update'
  end

  def destroy?
    allowed? 'forms:test:update'
  end

  def reorder?
    allowed? 'forms:test:update'
  end

end
