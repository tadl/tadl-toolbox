class CoversController < ApplicationController
	respond_to :html, :json, :js
	skip_before_action :verify_authenticity_token
  	def home
  		@covers = Cover.where(status: 'needs cover').paginate(:page => params[:page], :per_page => 10)
  	end

  	def new_cover
  		@record_id = params[:record_id]
  	end

  	def not_found
  		@covers = Cover.where(status: 'has cover').paginate(:page => params[:page], :per_page => 10)
  	end

  	def add_manually
  		
  	end

  	def cover_upload
  		@cover = Cover.find_by record_id: params[:record_id]
  		if !params[:coverart].nil?
  			@cover.coverart = params[:coverart]
  			if @cover.valid? == true
  				@message = 'success'
  				@cover.status = 'has cover'
  				@cover.save!
  			else
  				@message = 'fail'
  			end
  		elsif params[:remote_coverart_url]
  			@cover.remote_coverart_url = params[:remote_coverart_url]
  			if @cover.valid? == true
  				@message = 'success'
  				@cover.status = 'has cover'
  				@cover.save!
  			else
  				@message = 'fail'
  			end
  		else
  			@message = 'You must select an image for upload'
  		end
  	end
end
