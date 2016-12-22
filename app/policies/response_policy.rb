class ResponsePolicy < ApplicationPolicy

  def index?
    permissions(:response, :index).any? { |p| p['allowed'] }
  end

  def create?
    permissions(:response, :create).any? { |p| p['allowed'] }
  end

end