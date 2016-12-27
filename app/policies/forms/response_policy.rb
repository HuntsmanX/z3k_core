class Forms::ResponsePolicy < ApplicationPolicy

  def index?
    allowed? 'forms:response:view'
  end

  def show?
    allowed?('forms:response:view') || allowed?('forms:response:create')
  end

  def create?
    allowed? 'forms:response:create'
  end

end
