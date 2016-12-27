module PolicyHelper

  def allowed? key, &block
    permissions_for(key).any? do |p|
      block_given? ? yield(p.conditions) : true
    end
  end

  private

  def permissions_for key
    policy_permissions.select { |p| p.key == key }
  end

  def policy_permissions
    @permissions ||= user.permissions.select { |p| p.allowed }
  end

end


class ApplicationPolicy
  attr_reader :user, :record

  include PolicyHelper

  def initialize user, record
    @user = user || GuestUser.new
    @record = record.is_a?(Array) ? record.last : record
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    include PolicyHelper

    def initialize user, scope
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

end
