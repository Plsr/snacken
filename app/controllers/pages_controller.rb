# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :require_login, onlyy: [:home]
  def home; end
end
