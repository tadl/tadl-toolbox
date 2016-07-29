class List < ActiveRecord::Base
	require "addressable/uri"
	require 'httparty'
	validates :name, presence: true, uniqueness: {message: "A list with this name already exisits"} 
	validates :code, presence: true, uniqueness: {message: "A list with this name already exisits"}

	def check_url
		good_url = false
	 	if  self.url
	 		if Addressable::URI.parse(self.url).host == 'catalog.tadl.org' && confirm_items(self.url) == true		
	 			good_url = true
	 		end
	 	end
	 	return good_url
	end

	private

	def confirm_items(url)
		request = HTTParty.get(url).parsed_response
		if request['items'] 
			return true
		else
			return false
		end
	end


end
