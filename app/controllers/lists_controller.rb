class ListsController < ApplicationController
	before_action :authenticate_user!, :except => [:show_list]
	before_filter(:only => :show_list) do |controller|
   		authenticate_user! unless controller.request.format.json?
 	end
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
  			list.code = URI.encode(list.name.gsub(/\s+/, ''))
  			list.admin_id = current_user.id
  			if list.check_url == true
  				@list_id = list.id
  				@list_code = list.code
  				@list_name = list.name
  				@message = 'success'
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
  		@lists = current_user.lists.all
  	end

  	def show_list
  		if params['code']
  			@items = Rails.cache.fetch(params['code'].to_s)
  			@list = List.find_by code: params['code']
  		end
  		respond_to do |format|
  			format.html
  	    	format.json {render :json => {:search_url=>  @list.url, :items => @items}}
  	  	end
  	end

  	def refresh_list
  		if params['list_id']
  			list_id = params['list_id'].to_i
  			list = List.find(list_id)
  			if list.check_url == true
  				@message = 'success'
  			else
  				@message = 'fail'
  			end
  		end
  		respond_to do |format|
  	    	format.js
  	  	end
  	end

  	def delete_list
  		@message = 'fail'
  		if params['list_id']
  			list_id = params['list_id'].to_i
  			list = List.find(list_id)
  			if list.admin_id == current_user.id
  				list.destroy
  				@message = 'success'
  			else
  				@message = 'not your list'
  			end
  		end
  		respond_to do |format|
  	    	format.js
  	  	end
  	end
end
