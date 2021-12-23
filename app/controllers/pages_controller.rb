# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :require_login, only: [:home]
  def home; end
  def landing; end
end
