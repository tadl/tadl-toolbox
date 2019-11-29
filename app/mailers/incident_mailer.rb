class IncidentMailer < ApplicationMailer
  add_template_helper(IncidentsHelper)
  default from: "tech@tadl.org"

  def incident_email(incident)
    @incident = incident
    @to =  ENV["INCIDENT_EMAIL_LIST"]
    @subject = "New Incident: "
    if !@incident.title.nil?
      @subject += @incident.title  
    end
    mail(to: @to, subject: @subject)
  end

end
