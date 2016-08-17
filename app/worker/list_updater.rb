class ListUpdater < ApplicationController
  include Sidekiq::Worker

  def perform()
  	lists = List.all
  	lists.each do |l|
  		l.check_url
  	end
  end
  Sidekiq::Cron::Job.create(name: 'update lists - every 1 hour', cron: '00 * * * *', class: 'ListUpdater')

end