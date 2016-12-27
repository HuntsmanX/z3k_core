class Forms::Response::SectionPolicy < ApplicationPolicy

  def show?
    allowed? 'forms:response:view'
  end

  def update?
    allowed? 'forms:response:update'
  end

end
