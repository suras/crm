class UsersController < ApplicationController
  before_filter :authenticate_user!
  layout "candidate"
  def index
    @team = current_user.team
    @candidates = @team.try(:candidates)
  end
end
