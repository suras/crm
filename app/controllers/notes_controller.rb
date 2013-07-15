class NotesController < ApplicationController
  def update
  end
  def create
    @note  = current_user.notes.create(params[:note])
    respond_to do |f|
      f.html
      f.json{ render :json=>@note.to_json }
    end
  end
  def new
  end
  def show
  end
  def index
  end
end
