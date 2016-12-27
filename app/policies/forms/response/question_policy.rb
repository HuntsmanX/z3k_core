class Forms::Response::QuestionPolicy < ApplicationPolicy

  def update?
    allowed? 'forms:response:update'
  end

end
