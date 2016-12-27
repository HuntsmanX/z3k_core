class Forms::TesteePolicy < ApplicationPolicy

  def find?
    allowed? 'forms:response:create'
  end

end
