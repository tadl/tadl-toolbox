class Violation < ActiveRecord::Base
  belongs_to :incident
  belongs_to :patron
end
