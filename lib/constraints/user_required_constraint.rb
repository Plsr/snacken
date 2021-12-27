class UserRequiredConstraint
  include RouteConstraints::UserConstraint

  def matches?(request)
    current_user(request).present?
  end
end