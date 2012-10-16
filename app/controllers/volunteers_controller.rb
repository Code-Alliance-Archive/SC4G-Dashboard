class VolunteersController < ApplicationController
  # GET /volunteers
  # GET /volunteers.json
  #before_filter :authenticate_member!
  def index

    @volunteers = Volunteer.all

    name_filter = params[:name]
    email_filter = params[:email]
    company_filter = params[:company]
    skills = params[:skills]
    orgs_interested_in = params[:orgs_interested_in]
    causes_interested_in = params[:causes_interested_in]
    languages_interested_in = params[:languages_interested_in]
    time_to_commit = params[:time_to_commit]
    open_source_projects = params[:open_source_projects]


    @volunteers = Volunteer.scoped #.joins("LEFT OUTER JOIN webform_submitted_data ON volunteers.id=webform_submitted_data.sid WHERE webform_submitted_data.cid=17").scoped
    @volunteers = @volunteers.by_name(name_filter) if !name_filter.nil? && !name_filter.blank?
    @volunteers = @volunteers.by_email(email_filter) if !email_filter.nil? && !email_filter.blank?
    @volunteers = @volunteers.by_company(company_filter) if !company_filter.nil? && !company_filter.blank?
    @volunteers = @volunteers.by_time_to_commit(time_to_commit) if !time_to_commit.nil? && !time_to_commit.blank?
    @volunteers = @volunteers.by_open_source_projects(open_source_projects) if !open_source_projects.nil? && !open_source_projects.blank?

    if !skills.nil? && !skills.blank?
      skills.each do |s|
        @volunteers = @volunteers.by_skills(s)
      end
    end

    if !orgs_interested_in.nil? && !orgs_interested_in.blank?
      orgs_interested_in.each do |s|
        @volunteers = @volunteers.by_orgs_interested_in(s)
      end
    end

    if !causes_interested_in.nil? && !causes_interested_in.blank?
      causes_interested_in.each do |s|
        @volunteers = @volunteers.by_causes_interested_in(s)
      end
    end

    if !languages_interested_in.nil? && !languages_interested_in.blank?
      languages_interested_in.each do |s|
        @volunteers = @volunteers.by_languages_interested_in(s)
      end
    end

    respond_to do |format|
      format.html
      format.json{}
    end
  end

  # GET /volunteers/1
  # GET /volunteers/1.json
  def show
    @volunteer = Volunteer.find(params[:id])

    #respond_to do |format|
    #  format.html # show.html.erb
    #  format.json { render json: @volunteer }
    #end
  end

  # GET /volunteers/new
  # GET /volunteers/new.json
  def new
    @volunteer = Volunteer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @volunteer }
    end
  end

  # GET /volunteers/1/edit
  def edit
    @volunteer = Volunteer.find(params[:id])
  end

  # POST /volunteers
  # POST /volunteers.json
  def create
    @volunteer = Volunteer.new(params[:volunteer])

    respond_to do |format|
      if @volunteer.save
        format.html { redirect_to @volunteer, notice: 'Volunteer was successfully created.' }
        format.json { render json: @volunteer, status: :created, location: @volunteer }
      else
        format.html { render action: "new" }
        format.json { render json: @volunteer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /volunteers/1
  # PUT /volunteers/1.json
  def update
    @volunteer = Volunteer.find(params[:id])

    respond_to do |format|
      if @volunteer.update_attributes(params[:volunteer])
        format.html { redirect_to @volunteer, notice: 'Volunteer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @volunteer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /volunteers/1
  # DELETE /volunteers/1.json
  def destroy
    @volunteer = Volunteer.find(params[:id])
    @volunteer.destroy

    respond_to do |format|
      format.html { redirect_to volunteers_url }
      format.json { head :no_content }
    end
  end
end
