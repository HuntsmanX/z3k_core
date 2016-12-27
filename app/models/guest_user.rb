class GuestUser

  PERMISSIONS = [
    'forms:response:view',
    'forms:response:update'
  ]

  def permissions
    @permissions ||= get_permissions
  end

  private

  def get_permissions
    PERMISSIONS.map { |key| Permission.new key: key, allowed: true }
  end

end
