class IncidentsController < ApplicationController
  before_action :authenticate_user!,
  
  def list_incidents
    @incidents = Incident.all
  end

  def currently_susupended
  end

  def all_patrons
    @patrons = Patron.all
  end

  def new_incident
    @incident = Incident.new
    @patrons = Patron.all
  end

  def save_incident
    if params[:date_of]
      params[:date_of] = params[:date_of].to_datetime 
    end
    @incident = Incident.new(incident_params)
    @incident.save!
    respond_to do |format|
      format.js
    end
  end

  def new_patron
  end

  def save_patron
    @patron = Patron.new(patron_params)
    @patron.save!
    respond_to do |format|
      format.js
    end
  end

  def edit_patron
    @patron = Patron.find(params[:id])
  end

  def update_patron
    @patron = Patron.find(params[:id])
    @patron.update(patron_params)
    respond_to do |format|
      format.js
    end
  end

  def delete_patron_pic
    @patron = Patron.find(params[:id])
    @i = params[:i].to_i
    @patron.delete_patron_pic(@i)
    @patron.save!
    respond_to do |format|
      format.js
    end
  end

  def make_primary_patron_pic
    @patron = Patron.find(params[:id])
    @i = params[:i].to_i
    @patron.make_primary_patron_pic(@i)
    @patron.save!
    respond_to do |format|
      format.js
    end
  end

  def patron_search
    if params[:query] == ''
      @patrons = Patron.all
    else
      @patrons = Patron.search_by_name_alias(params[:query])
    end
    if params[:age_range] && params[:age_range] != ''
      age_range = params[:age_range].split(',')
      @patrons = @patrons.where(age: age_range[0]..age_range[1])
    end
    if params[:gender] && params[:gender] != ''
      @patrons = @patrons.where(gender: params[:gender])
    end
    respond_to do |format|
      format.js
    end
  end

  def eg_lookup
  end


  def new_violation
  end

  def currently_susupended
  end

  def search_incidents
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def patron_params
      params.permit(:no_name, :no_address, :first_name, :middle_name, :last_name, :alias, :address, :city, :state, :zip, :card_number, :gender, :age, :physical_description, patronpic: [])
  end

  def incident_params
      params.permit(:date_of, :location, :department, :title, :description, :no_patrons, incidentpic: [])
  end
end
