class CoversController < ApplicationController
	respond_to :html, :json, :js
	skip_before_action :verify_authenticity_token
  	def home
  		@covers = Cover.paginate(:page => params[:page], :per_page => 10)
  	end

  	def new_cover
  		@record_id = params[:record_id]
  	end

  	def not_found
  	end

  	def add_manually
  		
  	end

  	def cover_upload
  		@cover = Cover.find_by record_id: params[:record_id]
  		@cover.coverart = params[:file]
  		if @cover.valid? == true
  			@message = 'success'
  			@cover.save!
  		else
  			@message = 'fail'
  		end
  	end
end
