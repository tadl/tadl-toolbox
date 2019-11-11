module IncidentsHelper
  def test_for_existing_violation(patron, incident, violationtype_id)
    violations = Violation.where(patron_id: patron, incident_id: incident)
    violations.each do |i|
      if i.violationtype.id == violationtype_id
        return 'checked'
      end
    end
  end
end
