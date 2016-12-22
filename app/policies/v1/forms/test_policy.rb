class V1::Forms::TestPolicy < ApplicationPolicy

  def index?
    permissions(:test, :index).any? { |p| p['allowed'] }
  end

  def create?
    permissions(:test, :create).any? { |p| p['allowed'] }
  end

  def edit?
    permissions(:test, :edit).any? { |p| p['allowed'] }
  end

  def destroy?
    permissions(:test, :delete).any? { |p| p['allowed'] }
  end

end