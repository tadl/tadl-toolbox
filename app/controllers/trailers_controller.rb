class TrailersController < ApplicationController
	before_action :authenticate_user!, :except => [:get_trailer]
	before_filter(:only => :get_trailer	) do |controller|
   		authenticate_user! unless controller.request.format.json?
 	end
  before_filter :set_headers
	respond_to :html, :json, :js

	def queue
    @trailers = Trailer.where(:youtube_url => nil, :cant_find => false).paginate(:page => params[:page], :per_page => 10)
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

  def not_found
    @trailers = Trailer.where(:youtube_url => nil, :cant_find => true).paginate(:page => params[:page], :per_page => 10)
    if params[:page] == nil
      @current_page = 1
    else
      @current_page = params[:page]
    end
    respond_with do |format|
      format.js {}
      format.html {render :queue } 
    end
  end

	def by_id
    @trailer = Trailer.where(:record_id => params[:id].to_i)[0]
    if @trailer.nil?
      if params[:id] 
        @trailer = Trailer.new
        check_valid = @trailer.set_attributes(params[:id])
      else
        puts "got here"
      end
    end
    respond_with do |format|
      format.js {}
      format.html {} 
    end
	end

  def get_trailer
  end

  def mark_not_found
  end

  def add_trailer
  end

  def remove_trailer
  end

end