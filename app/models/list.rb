class List < ActiveRecord::Base
	require "addressable/uri"
	require 'httparty'
	validates :name, presence: true, uniqueness: {message: "A list with this name already exisits"} 
	validates :code, presence: true, uniqueness: {message: "A list with this name already exisits"}

	def check_url
		good_url = false
	 	if  self.url
	 		if self.url.include?'.json'
	 			url = self.url
	 		else
	 			split_url = self.url.split('?')
	 			url = split_url[0] + '.json?' + split_url[1]
	 		end
	 		puts url
	 		if Addressable::URI.parse(self.url).host == 'catalog.tadl.org' && confirm_items(url) == true		
	 			good_url = true
	 		end
	 	end
	 	return good_url
	end

	private

	def confirm_items(url)
		response = HTTParty.get(url).parsed_response
		if response['items']
			check_covers_and_save_to_cache(response['items']) 
			return true
		else
			return false
		end
	end

	def check_covers_and_save_to_cache(items)
		results_with_images = Array.new
		items.each do |i|
            url = 'https://catalog.tadl.org/opac/extras/ac/jacket/medium/r/' + i['id'].to_s
            image = MiniMagick::Image.open(url) 
            if image != nil
                if image.width > 2
                    results_with_images.push(i)
                end
            end
            if !image.nil?
              image.destroy!
            end
        end
        Rails.cache.write(self.code, results_with_images)
	end

end
