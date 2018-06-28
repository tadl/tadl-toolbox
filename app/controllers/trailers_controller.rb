class TrailersController < ApplicationController
	before_action :authenticate_user!, :except => [:get_trailer]
	before_filter(:only => :get_trailer	) do |controller|
   		authenticate_user! unless controller.request.format.json?
 	end
  	before_filter :set_headers
	respond_to :html, :json, :js

	def queue
	end

	def search_by_title
	end

	def add_record
	end


end