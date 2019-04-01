class TrailersController < ApplicationController
	before_action :authenticate_user!, :except => [:get_trailer]
	before_filter(:only => :get_trailer	) do |controller|
   		authenticate_user! unless controller.request.format.json?
 	end
  before_filter :set_headers
	respond_to :html, :json, :js

	def queue
    @trailers = Trailer.where(:youtube_url => nil, :cant_find => false).paginate(:page => params[:page], :per_page => 10)
    @trailers_count = @trailers.count.to_s
    @state = 'queue'
    @page_title = @trailers_count +' Videos Need Trailers'
    if params[:page] == nil
    @current_page = 1
    else
    @current_page = params[:page]
    end
    respond_with do |format|
      format.js {}
      format.html {}
    end
	end

	def search_by_title
	end

	def add_record
	end


end