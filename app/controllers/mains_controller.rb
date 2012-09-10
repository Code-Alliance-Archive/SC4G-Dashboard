class MainsController < ApplicationController
  # GET /mains
  # GET /mains.json
  def index
    @volunteers = Volunteer.all
  end
end


