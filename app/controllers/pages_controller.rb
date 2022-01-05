# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :require_login, except: %i[home]

  def home
    @meal_plan     = current_user.current_meal_plan
    @recipes       = current_user.recipes.limit(3)
    @shopping_list = current_user.current_shopping_list
  end

  def landing
    @beta_candidate = BetaCandidate.new
  end

  def privacy_policy; end

  def imprint; end
end
