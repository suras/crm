class HomeController < ApplicationController
  before_filter :check_login, :except=>[:landing]
  def index
  	render layout: false
  end
  def check_login
  	redirect_to search_path if current_user
  end
  def landing
  end
  def pricing
  	 redirect_to  search_path() and return if current_user
  	render layout: false
  end
end
