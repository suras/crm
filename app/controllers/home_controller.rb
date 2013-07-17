class HomeController < ApplicationController
  before_filter :check_login
  def index
  	render layout: false
  end
  def check_login
  	redirect_to search_path if current_user
  end
end
