class IncidentsController < ApplicationController
  before_action :authenticate_user!,
  
  def list_incidents
    @incidents = Incident.all
  end

  def currently_susupended
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
  end

  def new_violation
  end

  def currently_susupended
  end

  def search_incidents
  end

end
