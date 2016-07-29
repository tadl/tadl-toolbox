class ListsController < ApplicationController
	respond_to :html, :json, :js
  	def show_lists
  		@lists = List.all
  	end

  	def create_lists
  	end

  	def save_list
  		@nlist_id = ''
  		@list_name = ''
  		@list_code = ''
  		if params['url'].blank? || params['name'].blank?
  			@message = 'missing parameters'
  		else
  			list = List.new
  			list.name = params['name']
  			list.url = params['url']
  			list.code = URI.encode(list.name)
  			list.created_by = current_user.id
  			if list.check_url == true
  				confirmation = list.save
  				if confirmation == true
  					@list_id = list.id
  					@list_code = list.code
  					@list_name = list.name
  					@message = 'success'
  				else
  					@message = list.errors.messages.values[0][0].to_s
  				end
  			else
  				@message = 'Invalid Url'
  			end
  		end
  		respond_to do |format|
  	    	format.js
  	    	format.json {render :json => {:message => @message, :list_name => @list_name, :list_id => @list_id, :list_code => @list_code}}
  	  	end
  	end

  	def edit_lists
  	end

  	def my_lists
  		@lists = List.all
  	end
end
