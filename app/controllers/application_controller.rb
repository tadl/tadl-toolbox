class ApplicationController < ActionController::Base
  	# Prevent CSRF attacks by raising an exception.
  	# For APIs, you may want to use :null_session instead.
  	protect_from_forgery with: :exception
  	private
  	def current_user
    	@current_user ||= Admin.find(session[:user_id]) if session[:user_id]
  	end

    def super_admin
      ENV["SUPER_ADMIN_EMAILS"].split(',').include? current_user.email
    end

  	def authenticate_user!
      	if !current_user
        	redirect_to root_url, :alert => 'You need to sign in for access to this page.'
      	end
  	end

    def super_admin!
      if !current_user || !super_admin
        redirect_to root_url, :alert => 'You need to sign in for access to this page.'
      end
    end


    def set_headers
      headers['Access-Control-Allow-Origin'] = '*'      
    end 
     
  	helper_method :current_user
    helper_method :super_admin
end
