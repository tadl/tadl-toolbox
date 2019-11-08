class Violation < ActiveRecord::Base
  has_one :violationtype
  belongs_to :incident
  belongs_to :patron
end
