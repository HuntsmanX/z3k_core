class V1::Forms::ResponsePolicy <  ApplicationPolicy

  def index?
    permissions(:response, :index).any? { |p| p['allowed'] }
  end

  def show?
    permissions(:response, :show).any? { |p| p['allowed'] }
  end

  def create?
    permissions(:response, :create).any? { |p| p['allowed'] }
  end

end