class NoUserRequiredConstraint
  include RouteConstraints::UserConstraint

  def matches?(request)
    current_user(request).blank?
  end
end
