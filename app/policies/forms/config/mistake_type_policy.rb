class Forms::Config::MistakeTypePolicy < ApplicationPolicy

  def index?
    allowed? 'forms:mistake_type:view'
  end

  def show?
    allowed? 'forms:mistake_type:view'
  end

  def create?
    allowed? 'forms:mistake_type:update'
  end

  def update?
    allowed? 'forms:mistake_type:update'
  end

  def destroy?
    allowed? 'forms:mistake_type:delete'
  end

end
