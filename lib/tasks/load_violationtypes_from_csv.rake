desc "load violation types from types for csv"
task :violationtypes_from_csv => :environment do
  require 'csv'
  require 'open-uri'
  require 'json'
  CSV.foreach("#{Rails.root}/db/violationtypes.csv", :encoding => 'windows-1251:utf-8') do |x|
    v = Violationtype.new
    v.description = x[0]
    v.first_offence = x[1]
    v.second_offence = x[2]
    v.subsiquent_offence = x[3]
    if x[0][0] == 'A'
      v.track = 'A'
    elsif x[0][0] == 'B'
      v.track = 'B'
    else
      v.track = 'None'
    end
    v.save!
  end
end