module PolicyHelper

  def permissions resource, action
    key = resource.to_s + '_' + action.to_s
    policy_permissions.select { |p| p['key'] == key}
  end

  private

  def policy_permissions
    @permissions ||= @user.permissions
  end

end


class ApplicationPolicy
  attr_reader :user, :record

  include PolicyHelper

  def initialize(user, record)
    @user = user
    @record = record.is_a?(Array) ? record.last : record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end