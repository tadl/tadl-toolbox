module IncidentsHelper
  def test_for_existing_violation(patron_id, incident_id, violationtype_id)
    violations = Violation.where(patron_id: patron_id, incident_id: incident_id)
    violations.each do |i|
      if i.violationtype.id == violationtype_id
        return 'checked'
      end
    end
  end

  def check_for_violations(patron_id, incident_id)
    violations = Violation.where(patron_id: patron_id, incident_id: incident_id)
    if violations.size >= 1
      return true
    else
      return false
    end
  end

  def incident_picture_helper(incident)
    url = ''
    if incident.primary_pic_small
      url = incident.primary_pic_small
    elsif incident.violations
      incident.violations.each do |v|
        if v.patron.primary_pic_small
          url = v.patron.primary_pic_small
        end
      end
    end
    if url == ''
      url = asset_path('missing_pic.png')
    end
    return url
  end

end
