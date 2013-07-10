class UsersController < ApplicationController
  before_filter :authenticate_user!
  def index
    @team = current_user.team
    @candidates = @team.candidates
  end
end
