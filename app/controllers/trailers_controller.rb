class TrailersController < ApplicationController
	before_action :authenticate_user!, :except => [:get_trailer]
	before_filter(:only => :) do |controller|
   		authenticate_user! unless controller.request.format.json?
 	end
  	before_filter :set_headers
	respond_to :html, :json, :js
end