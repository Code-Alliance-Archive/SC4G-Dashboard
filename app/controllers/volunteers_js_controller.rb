class VolunteersJsController < ApplicationController
  # GET /volunteers_js
  # GET /volunteers_js.json
  def index
    #@volunteers_js = VolunteersJ.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /volunteers_js/1
  # GET /volunteers_js/1.json
  def show
    @volunteers_j = VolunteersJ.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @volunteers_j }
    end
  end

  # GET /volunteers_js/new
  # GET /volunteers_js/new.json
  def new
    @volunteers_j = VolunteersJ.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @volunteers_j }
    end
  end

  # GET /volunteers_js/1/edit
  def edit
    @volunteers_j = VolunteersJ.find(params[:id])
  end

  # POST /volunteers_js
  # POST /volunteers_js.json
  def create
    @volunteers_j = VolunteersJ.new(params[:volunteers_j])

    respond_to do |format|
      if @volunteers_j.save
        format.html { redirect_to @volunteers_j, notice: 'Volunteers j was successfully created.' }
        format.json { render json: @volunteers_j, status: :created, location: @volunteers_j }
      else
        format.html { render action: "new" }
        format.json { render json: @volunteers_j.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /volunteers_js/1
  # PUT /volunteers_js/1.json
  def update
    @volunteers_j = VolunteersJ.find(params[:id])

    respond_to do |format|
      if @volunteers_j.update_attributes(params[:volunteers_j])
        format.html { redirect_to @volunteers_j, notice: 'Volunteers j was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @volunteers_j.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /volunteers_js/1
  # DELETE /volunteers_js/1.json
  def destroy
    @volunteers_j = VolunteersJ.find(params[:id])
    @volunteers_j.destroy

    respond_to do |format|
      format.html { redirect_to volunteers_js_url }
      format.json { head :no_content }
    end
  end
end
