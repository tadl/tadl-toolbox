class IncidentMailer < ApplicationMailer
  default from: "tech@tadl.org"

  def incident_email(incident)
    @incident = incident
    @to =  'tech@tadl.org'
    @subject = "New Incident: "
    if !@incident.title.nil?
      @subject += @incident.title  
    end
    mail(to: @to, subject: @subject)
  end

end
