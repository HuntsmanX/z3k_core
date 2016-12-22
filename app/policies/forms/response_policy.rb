class Forms::ResponsePolicy <  ApplicationPolicy

  def index?
    allowed?(:response, :index)
  end

  def show?
    allowed?(:response, :show)
  end

  def create?
    allowed?(:response, :create)
  end

end