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
  end

  def save_incident
  end

  def new_patron
  end

  def eg_lookup
  end

  def pg_lookup
  end

  def save_patron
    @patron = Patron.new(patron_params)
    @patron.save!
    respond_to do |format|
      format.js
    end
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

end
