module RouteConstraints
  module UserConstraint
    def current_user(request)
      User.find(request.session[:user_id])
    end
  end
end
