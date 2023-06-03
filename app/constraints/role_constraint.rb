class RoleConstraint
  def initialize(roles)
    raise ArgumentError, 'Roles must be an array' unless roles.is_a?(Array)

    @roles = roles.map(&:to_sym)
  end

  def matches?(request)
    return false unless request.env['warden'].user

    @roles.include?(request.env['warden'].user.role.to_sym)
  end
end
