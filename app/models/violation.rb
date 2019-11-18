class Violation < ActiveRecord::Base
  belongs_to :violationtype
  belongs_to :incident
  belongs_to :patron
  validates :patron_id, uniqueness: { scope: [:incident_id, :violationtype_id] }


  def violation_description
    return self.violationtype.description
  end

  def incident_title
    return self.incident.title
  end

end
