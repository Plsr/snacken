# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :require_login, only: [:home]
  def home 
    render component: 'HelloWorld', props: { greeting: 'Yo whaddup' }
  end
end
